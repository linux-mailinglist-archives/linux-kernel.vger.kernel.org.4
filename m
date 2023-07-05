Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AB747E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGEHYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:24:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891110DD;
        Wed,  5 Jul 2023 00:24:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99364ae9596so356735066b.1;
        Wed, 05 Jul 2023 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688541877; x=1691133877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBZ2V9YkgQb75fgLLwSDoK6jYDOYm9Ulfp2E4lReMu4=;
        b=Ft35BGtfPjUdUryqBygCiZrglZi6RQf2Uq33+EgA0PHGC9flgpkea796/5npXeaU++
         Fih8p0t82f+/DG0P3vVkiv8BOKDDFO8KYd3a223NUyrQRCyzPihenOF/qCb3hyDFpwOw
         RjkFpPbNfnlrOaGNK75AbYq/jninFCMWeiwYLCAXZyZrJwmBv4NZxcg0AiUVVShaeR8S
         8oaaOAKXVRP7xLGGvvS6kyRoZci1QMmuBHVtTvY+2Pj9aFdV/EQLboUzRBt06GCj4MDc
         CgzOd9blKo7RLN5OYBur6/Q2WG0hSwUGI6S7zz+3G6o5ctC829YZJOBXasBINlzadVee
         LB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541877; x=1691133877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBZ2V9YkgQb75fgLLwSDoK6jYDOYm9Ulfp2E4lReMu4=;
        b=Ht2gP1QfOhKd+lV1p16gEXS4bPhBx9HJ08oeW585YX+4ZbRwa4LS3NbiC3av+6v5eI
         GriVsPamOuYHsbEtwzV40/MWG0WwP+7gxGaUwxbZopDb9dSnbQ0MrVFzwq7yl8LWV1qy
         SuCJnRqB3QhfsD+1L42zZVXQ/TnHmHaHplmEAN6CD5H0FJQf9eoyM6shYgoI9h7JyJTq
         jR/jqyFyxmSLV31fuv3qbzTdCt7ojJzmsEMdywzrXRswC4XeXofPJ9vZwEdQeQm6aS7i
         iOFEMq73r7HWrPzX0Y3cutaRgQJEtNrznOHC/fH2hcn6rWWUdRGdL2F/uiOkpAGYwElF
         tyKg==
X-Gm-Message-State: AC+VfDxrRBN7PGPFaBMkWyOusmQQpreX5OAKwE6Myp0aUdMIywclRvcI
        N3ZHkV/VOMgt6uuzjibU/rFkV2TXLgZe/lLHVWpyCiemkfN2Wg==
X-Google-Smtp-Source: APBJJlEzktWAFzDyfTdF5aq95BVbZzgxZ4ow0qDGxVedpqTLBRPqSrErSM08kh3Ba8Fnen97931YBN7ZnQZfEtTq87k=
X-Received: by 2002:a17:907:100c:b0:973:ca9c:3e43 with SMTP id
 ox12-20020a170907100c00b00973ca9c3e43mr10435369ejb.45.1688541876875; Wed, 05
 Jul 2023 00:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
In-Reply-To: <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 5 Jul 2023 15:24:23 +0800
Message-ID: <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
Subject: Linux-6.5 iwlwifi crash
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest linux-6.4 after June 27 crash my whole linux notebook once
iwlwifi is loaded. Anyone seeing this?

Bisect? Or there's a patch for this?

# modprobe iwlwifi
... Whole system frozen!


Here's my system before the crash ...

# dmesg
cfg80211: Loading compiled-in X.509 certificates for regulatory database
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
thermal thermal_zone1: failed to read out thermal zone (-61)
iwlwifi 0000:00:14.3: Sorry - debug buffer is only 4096K while you
requested 65536K

# lspci
00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi
WiFi (rev 01)

# linux git log
commit d528014517f2b0531862c02865b9d4c908019dc4 (HEAD -> master,
origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 15:05:12 2023 -0700

# lsmodModule                  Size  Used by
iwlmvm                397312  0
mac80211              626688  1 iwlmvm
iwlwifi               307200  1 iwlmvm
cfg80211              413696  3 iwlmvm,iwlwifi,mac80211


Bisect?

Thanks,
Jeff.
