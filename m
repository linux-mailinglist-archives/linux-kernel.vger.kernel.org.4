Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9D5EC5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiI0O16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiI0O1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:27:42 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 07:27:36 PDT
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFCF3110
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=Jvhm/TIuEM3MbFSywD/lO6kvNC6ioA9KTEm2/WvlxWs=;
 b=pcu+k1UxuiKBY/ANP/l+Gu8iNx9ZLD8kVnwP8goJOpuBNh7Sr1ZEaM1gsEzTQi5YqH5sCCzYghpf
   VVg2Zzy3I7M/bNqJgM0xu0rsbDR2ber41bVJpRDRz80Wlpxg0Z/liqqXZxel4WJGEcmJ8H0wdZEy
   xFHFCl/ER/dDsqWWa2LxdVrdL2cxCSGJrpdFPupUARbplkLEZR56MtZfPhqCEpXL1y8W9jBe09AJ
   wEdEln618ml5XQFMVrpS7ibsMd6xGyh31i902j0A2D1KNujhxQzTkRzlHzmdsG/DI7DuPCR/D6a8
   ah821mFTSwpUcDmvTTBEK7L3PMtsDV15zDpq1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=Jvhm/TIuEM3MbFSywD/lO6kvNC6ioA9KTEm2/WvlxWs=;
 b=AHSIWBhGeYU2pbHx153qgw7wjk6FZxw+OmB/8N/tZlWharKw7JgrKAxBDZQ9x8zf44LZcP52H8Sq
   DIiM9Yv1JCBJOvS6T+u9N27bCqSOFUxGCW1AfCeUu1CK1e8Y0sd1SsTsfV3Ls+M3uF2E/lyvXgzV
   LNuEfcL+WYzdqJrKllLXCA6dGuVTCCXtzz3Qq/j4Qo/jodhbZFTFD4fGmDgflK8lB6tzr6iaqoj2
   CZ5xb9mx2BqFiXDcX7mJM70k/ubaoYtYSQoSUBgFiyyqU8HODnrQlsuVwt60NUvXy/jRLUk8rfOt
   BL9iOltwi0ucdxw/wgXpNz/RSFTJ3Xxiu+n9Yw==
Received: by omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220914 64bit (built Sep 14
 2022))
 with ESMTPS id <0RIV00NRMH9KG0B0@omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Tue, 27 Sep 2022 14:22:32 +0000 (GMT)
Message-id: <f84e4956-293f-801d-6b9f-df4226df87d2@augustwikerfors.se>
Date:   Tue, 27 Sep 2022 16:22:28 +0200
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
 <ea1f1d81-650b-768a-30ab-c9d7d9f9fa54@augustwikerfors.se>
 <3ba218a3-8b6b-c0da-873b-53e1a8a082ae@amd.com>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <3ba218a3-8b6b-c0da-873b-53e1a8a082ae@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGbJpr3NyLqWZHM6uELfmvsuJMi5ZNZQypbrRlArwbCKCICd6gU/Yml3uJOgk9C
 zSaCWCHXTdOH4I2OUeF/PgO1sCOokynEZbKMb6KcBELateo1A0z8dXCWT4SIa+xb
 OQZ/sC0izMHGGP3BRxsByBUoEbq9rDunxzLsk1tAh7G6dZ+WUCq2fsJaeiLehn2z
 v29Z0IBoBqnw0RfU7/HLqGXVlH0truW/1K2DKY6GJolnSGDuTCC8Vf8Rp69Kofhg
 rN0all19/cWCwLr0rnbyOp4xkM2m2Y0NnfwvxcsEiMnUyPsdRBdk0L685fhQTxyZ
 EjtM/GYtliSFLzYknmKfPYPi7Tjb8E7g3JpRMNskRazeBqGXwwzezw6q4mSoGNR7
 EmCkFmBBYk5I823yh+GMvjtaoMvEpagVHNqmcWkaEh+OjKCrIaVfEU6Bvvc+9uqh bO1EPw==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2022-09-27 00:29, Leo Li wrote:
> 
> Hi August, thanks for the log.
> 
> It seems the eDP panel does not fully satisfy the amdgpu requirements
> for enabling PSR SU, but we're enabling it anyways.
> 
> I suspect it may be due to the "DP_FORCE_PSRSU_CAPABILITY" bit being set
> in it's DPCD registers, I'm checking with some devs to see if that is
> expected.
> 
> In the meantime, can you give these two hacks a spin? Let me know if
> this helps with the glitches and system hangs:
> https://gitlab.freedesktop.org/-/snippets/7076
Yes, the issues do not happen with those patches applied.

> Also the dmesg, in particular this line:
>> [drm] PSR support 1, DC PSR ver 1, sink PSR ver 3 DPCD caps 
>> 0x70su_y_granularity 4 force_psrsu_cap **X**
Here is that line:
> [   12.085196] [drm] PSR support 1, DC PSR ver 1, sink PSR ver 3 DPCD caps 0x7b su_y_granularity 4 force_psrsu_cap 1

Regards,
August Wikerfors
