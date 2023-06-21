Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB27386D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFUOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjFUOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:25:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9321A8;
        Wed, 21 Jun 2023 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=y8KezyLc/DUW29gVzDAPim1rZ/zbq0krh1pHlYpx9Jc=;
        t=1687357521; x=1688567121; b=aXxUgrLfDYcIk0kZc3wQJZ6sJIQ2o5un5VkWjAa5NlI8Kd6
        1WqRe7bb8l/3ejKAnsk5oHtHsw0zTxs0s5SY0KUB5k2P8jPT0fucI5bM/dwbSmrOfyll3Fof/JJnT
        ncxLb0zpiFRtNF1E2fPMu+R+Jnpj0Y4si5vJ6/keFWlznZT/tYBN3RTBpH7thS4EByyeN6aGmCjqE
        wKKWcNMRjLT1eTsVTnsxRWOBGJ40Gr67obI6R0RmjCLwsTdPKLUGj8PN6oDt94ngltJAOmQ2/6g2L
        SiYmQhAFc2wTeOLv1Bsz35GGje2x1ot3MDJnOwsiYedhRd1Q3bdfJQh8CZhTPaBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qByln-00Dhei-0G;
        Wed, 21 Jun 2023 16:25:15 +0200
Message-ID: <9214266bf969207df60fdbde0157a0a5982bd2e0.camel@sipsolutions.net>
Subject: Re: [PATCH V4 3/8] wifi: mac80211: Add support for ACPI WBRF
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de
Date:   Wed, 21 Jun 2023 16:25:13 +0200
In-Reply-To: <9fdcd5a6-5315-b4d8-1662-30bfc6cb67d8@amd.com>
References: <20230621054603.1262299-1-evan.quan@amd.com>
         <20230621054603.1262299-4-evan.quan@amd.com>
         <3eb2c16cb0692c8d6b03bd57cb049b1fb3457e92.camel@sipsolutions.net>
         <9fdcd5a6-5315-b4d8-1662-30bfc6cb67d8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 09:12 -0500, Limonciello, Mario wrote:
> >=20
> > But then the next question anyway is how we merge this? The wifi parts
> > sort of depend on the first patch, although technically I guess I could
> > merge them since it's all hidden behind the CONFIG_ symbol, assuming yo=
u
> > get that in via some other tree it can combine upstream.
> >=20
> > I'd also say you can merge those parts elsewhere but I'm planning to
> > also land some locking rework that I've been working on, so it will
> > probably conflict somewhere.
> Since it's all gated by CONFIG_ACPI_WBRF for each subsystem that it touch=
es,
> my take is that we should merge like this:
>=20
> 1) Get A-b/R-b on patch 1 (ACPI patch) from Rafael.
> 2) Merge mac80211 bits through WLAN trees
> 3) Merge AMDGPU bits *and* ACPI bits through amd-staging-drm-next=20
> followed by drm tree
>=20
> Since WLAN and AMDGPU bits are using the exported ACPI functions from
> patch 1, we need to make sure that it is accepted and won't change
> interface before merging other bits.

Right.

> Everything can come together in the upstream tree and the bots
> will be able to test linux-next as well this way.

Yeah, that's what I thought.

Sounds good to me!

Oh, also, since it's pretty late in the cycle I'm assuming for now that
you're not aiming this for 6.5 anymore. If you still are, it all would
probably need to happen very quickly.

johannes
