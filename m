Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463965EEFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiI2H6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiI2H6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:58:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC61B13AF1A;
        Thu, 29 Sep 2022 00:58:11 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odoQr-0003iS-FK; Thu, 29 Sep 2022 09:58:09 +0200
Message-ID: <21558662-8b2a-9d57-4215-a24723700b81@leemhuis.info>
Date:   Thu, 29 Sep 2022 09:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Theodore Ts'o <tytso@mit.edu>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
 <20220929002500.283481-2-bryan.odonoghue@linaro.org>
 <YzURBpkWU1hHM7rN@mit.edu>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 1/2] get_maintainer: Describe supporters and
 maintainers as required email recipients
In-Reply-To: <YzURBpkWU1hHM7rN@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664438291;b90275f8;
X-HE-SMSGID: 1odoQr-0003iS-FK
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 05:29, Theodore Ts'o wrote:
> On Thu, Sep 29, 2022 at 01:24:59AM +0100, Bryan O'Donoghue wrote:
>> The output of get_maintainer.pl doesn't make clear that a supporter is a
>> type of maintainer who should be mailed when generating a patch.
>>
>> In various places in the documentation we make reference to the necessity
>> to remember to include the appropriate maintainers when sending your patch
>> but, we confusingly don't call out supporters as maintainers in our
>> automation utility.
>>
>> Fix that up now by having get_maintainers.pl print 'maintainer[volunteer]'
>> or 'maintainer[supporter]'.
> 
> I really don't think this is correct.  Or at least, I don't think it's
> consistent with how we've historically understood the S: term in the
> MAINTAINERS file. [...]

Hmm, yeah, you are right, I didn't think this trough when suggesting
"maintainer[volunteer]". @Bryan: sorry for leading your in the wrong
direction.

Ciao, Thorsten
