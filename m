Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDF5E83BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiIWUb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiIWUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:31:35 -0400
Received: from ach1ajh116.fra1.oracleemaildelivery.com (ach1ajh116.fra1.oracleemaildelivery.com [138.1.108.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A0A0304
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-fra1-20220101;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ndCYhNAZBZbgHcU18FVTrsBX5+3mkgNgpLzef++0BQU=;
 b=WFXGBT/rlEKu5laIFfFKgd8vFhz42tQQc4MkZ2RnsRTyFQ9WUfSreGMFUozstItmkMzxhU6T+GWm
   pId3LY53WLKhw7dMbhZhO7+WwSdOrceQSZ5Ir3VBTus/RJJ8BGJu4H0lSExH31XQl/O5EF2m0/v8
   XlqBZo02Jr9Md8Okw1CBbpABqMJnfOKhlPmSWQB10OrSCPpMz4JLDDcfnRa0CR5EfH411BpgzBfl
   u7GHlC3Z8pfWltB15580aTr0la0177Ptm9dszDaosM19ts5VDasEwuCrEW4rtx0vKGf64+AFu6/w
   qsNPdXoYnj3319VOnsjZAZIYlgWOJSNFUVeKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-fra-20191115;
 d=fra1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ndCYhNAZBZbgHcU18FVTrsBX5+3mkgNgpLzef++0BQU=;
 b=YShm9dfRt5NcsTk92nfsS2E8sP3EmKrfhSdE4rp4TeDYc9sbnZUMtNacW73CqsxUn65vTmhK3CRS
   en4iTs6nfyWltzRoXFCl+w0EEzUPXj9+7AqjHG4NufbhU+lsnbY7iZV1rZttuuXk9HDek7+nhNJ1
   l/bOsQBacVyV1Tgp9HknyW2Cb7VkUoPsUSrlbSUt9nX2U0UR9eIoXM+k3b4bG4EuDtwAr8oaQEo+
   2TN39mPyY9wehHaBydo+0WrHkUEQJ5nM2dloh4Z8ic/qeGZkTQ6Yjhdg1RhC0fmCZvwIGxIWv4C4
   5ihnQHNFZ/zAhKtgkPf5B5bj5uinAb+vLY5dOw==
Received: by omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220914 64bit (built Sep 14
 2022))
 with ESMTPS id <0RIO000VIJGHDL10@omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Fri, 23 Sep 2022 20:26:41 +0000 (GMT)
Message-id: <ea1f1d81-650b-768a-30ab-c9d7d9f9fa54@augustwikerfors.se>
Date:   Fri, 23 Sep 2022 22:26:35 +0200
MIME-version: 1.0
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since
 v6.0-rc1 (bisected)
Content-language: en-US
To:     Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
 <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
 <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEOL0javX7vJbTonMYC2eM4teWqEd60MX20U+3Im6izcE4iNa76d+RAkf65cWfX
 p514OTw7+zyMCBtIa6gcDTMiMR2v31KQAxK/xb203M4Vchq2Ym9DQL7zpleO+AGQ
 N3VGgds0agRl1XLhNoOsIFSgmp7P5JcoxlpuAQZtTYJgKon6aI3tww2L+Un8txzj
 h4eH1PwKLHLaiTzF2n+XWmdhywVrbZWsmlxla1L3zOWf8XWHbjrMlZt5KJdrLbwV
 E5QlRIljznw0VoRCjP2zlKQkYGQbvqeB4a5H/6tGCClP/IUvmnEIgwKkZ2qBQpWO
 up0NcE45yv6v7kKIK2zH1s3lIvpnn8JZuGNO/NvRxoyUi8usTMhRu0B0BaqcmIOH
 pnuL01jcFkSFirvCf7+BdInv2qtO1LgNUII8SwkLWQG6KKzf8Am0rrpKpQR86Zk2 1nl8uPEY
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2022-09-23 20:41, Leo Li wrote:
> Hi August,
> 
> Can you provide a dmesg log with drm.debug=0x16 enabled in kernel cmdline?
Log is available here: https://files.augustwikerfors.se/dmesg.2022-09-23.txt

This is what I did during that log:
1. Boot the system
2. Type into the password field in SDDM (this is when the problem occurs)
3. Switch to a TTY to save the log (the problem doesn't happen there)

Regards,
August Wikerfors
