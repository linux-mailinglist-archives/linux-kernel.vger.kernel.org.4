Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0B746BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGDIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjGDIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:31:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19F1735;
        Tue,  4 Jul 2023 01:30:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qGbQr-0002q1-59; Tue, 04 Jul 2023 10:30:45 +0200
Message-ID: <00d9ec8a-5a44-01ec-a51f-ac898152e22c@leemhuis.info>
Date:   Tue, 4 Jul 2023 10:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Language: en-US, de-DE
To:     Sardonimous <sardonimous@hotmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
 <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <89429625-5b5a-d0d3-ae82-0b7204262980@lwfinger.net>
 <RO2P215MB19383189863E11A1B242E02BA729A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <RO2P215MB19383189863E11A1B242E02BA729A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688459451;31adccc9;
X-HE-SMSGID: 1qGbQr-0002q1-59
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.23 22:13, Sardonimous wrote:
> On 7/3/23 12:35 PM, Larry Finger wrote:
>> Sorry that it took so long to get back to you.
>>
>> For my ppc32, there is no regression. It took a while to learn the
>> pio=1 and qos=0 are BOTH needed. That I do not understand, but with
>> both set, the device works with kernel 6.4 and all earlier kernels
>> that I tried. Fortunately, I did not need to do the entire bisection.
>>
>> I am working on eliminating the warning that appears with qos=0, but
>> it does not inhibit operations.
>>
>> @Bagas Sanjaya: Please mark this "regression" as invalid.
>>
>> Larry
>>
> I appreciate the time you've spent on this. 

Yeah, thx from my side, too.

#regzbot invalid: wasn't a regression after all
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


