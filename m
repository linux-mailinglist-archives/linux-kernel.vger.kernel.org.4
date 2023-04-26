Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442436EECBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjDZDaf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 23:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDZDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:30:31 -0400
Received: from gfmail1.glenfly.com (gfmail1.glenfly.com [113.31.180.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED11FE1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:30:28 -0700 (PDT)
X-ASG-Debug-ID: 1682479824-196b4b151014a360001-xx1T2L
Received: from GFSHEXCH01.glenfly.com (GFSHEXCH01.glenfly.com [10.5.250.51]) by gfmail1.glenfly.com with ESMTP id GWavQAfSndyKb7II; Wed, 26 Apr 2023 11:30:24 +0800 (CST)
X-Barracuda-Envelope-From: ReaperLiOC@glenfly.com
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.51
Received: from GFSHEXCH03.glenfly.com (10.5.250.53) by GFSHEXCH01.glenfly.com
 (10.5.250.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 26 Apr
 2023 11:30:51 +0800
Received: from GFSHEXCH03.glenfly.com ([fe80::1cb2:fbd4:8e34:2eb5]) by
 GFSHEXCH03.glenfly.com ([fe80::1cb2:fbd4:8e34:2eb5%4]) with mapi id
 15.01.2507.023; Wed, 26 Apr 2023 11:30:48 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.51
From:   Reaper Li_OC <ReaperLiOC@glenfly.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "Jason Tao(SH-RD)" <JasonTao@glenfly.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI
 Codec Vendor IDs.
Thread-Topic: [PATCH v2] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI
 Codec Vendor IDs.
X-ASG-Orig-Subj: Re: [PATCH v2] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI
 Codec Vendor IDs.
Thread-Index: AQHZd+9+IH8ECITzIk+wuN5IV44p4Q==
Date:   Wed, 26 Apr 2023 03:30:48 +0000
Message-ID: <20230426033609.GA18215@sqa-PC>
References: <20230425101524.8020-1-reaperlioc@glenfly.com>
 <875y9kujue.wl-tiwai@suse.de>
In-Reply-To: <875y9kujue.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.30.16.40]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B08414F2993B34693714F7436D19FF2@glenfly.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: GFSHEXCH01.glenfly.com[10.5.250.51]
X-Barracuda-Start-Time: 1682479824
X-Barracuda-URL: https://10.5.252.51:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at glenfly.com
X-Barracuda-Scan-Msg-Size: 177
X-Barracuda-Bayes: SPAM GLOBAL 0.9990 1.0000 4.3308
X-Barracuda-Spam-Score: 4.33
X-Barracuda-Spam-Status: No, SCORE=4.33 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107938
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This is almost fine, but could just correct minor warnings
> scripts/checkpatch.pl complains?

Appreciate for your help, have fixed the warnings and resend the v3
patch.
