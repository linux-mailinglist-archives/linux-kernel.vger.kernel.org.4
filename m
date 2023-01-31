Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0059683190
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjAaPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjAaPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:32:31 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 07:32:31 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C757199FB;
        Tue, 31 Jan 2023 07:32:31 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id EC25A11F6B51;
        Tue, 31 Jan 2023 16:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1675178012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEAFekxO4H1r0D0uCq8wnBQbhqfRc6NLBnWGl+JsmXc=;
        b=tjKz44pDJwB6f8baVJEvgny1EJsyMst+Y/ZkdXo6IoXPslCNquifKGGDuTBpDrJsCBe2Ky
        g6RyIOi/LTpj+Id7xPevFkXwYi99T4Sho7F8ZnU4Iq2Lkb265x52TShUvMwLfY8SGdj0Yv
        HO1C6GCKW6by2OC8izCMKYkkoeW9lEE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com, torvic9@mailbox.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Subject: Re: [PATCH v4 0/6] amd_pstate: Add guided autonomous mode support
Date:   Tue, 31 Jan 2023 16:13:30 +0100
Message-ID: <5643269.DvuYhMxLoT@natalenko.name>
In-Reply-To: <1501106335.274.1675161471528@office.mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <1501106335.274.1675161471528@office.mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =FAter=FD 31. ledna 2023 11:37:51 CET torvic9@mailbox.org wrote:
> Can you rebase this patchset onto the newest EPP v12 series [1] ?
>=20
> [1] https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@=
amd.com/

You may consider trying my rebase here: [1].

This commit applies to v11+v3 series. I hope I didn't miss anything.

If interested, please let me know whether it works for you.

Thanks.

[1] https://codeberg.org/pf-kernel/linux/commit/438525b8029b23967722e9c7af9=
7c6b8deb25029

=2D-=20
Oleksandr Natalenko (post-factum)


