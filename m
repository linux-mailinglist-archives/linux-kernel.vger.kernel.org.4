Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32573B408
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFWJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:46:57 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1DE48;
        Fri, 23 Jun 2023 02:46:55 -0700 (PDT)
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qCdNR-00Dbvf-Tr; Fri, 23 Jun 2023 10:46:50 +0100
MIME-Version: 1.0
Date:   Fri, 23 Jun 2023 10:46:50 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v8 0/5] DesignWare PWM driver updates
In-Reply-To: <daffc540-3b99-f71d-538b-84c897730208@linux.intel.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <daffc540-3b99-f71d-538b-84c897730208@linux.intel.com>
Message-ID: <1634a34bcd0f1b6eed5e3d59126d7892@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-20 13:59, Jarkko Nikula wrote:
> On 6/14/23 20:14, Ben Dooks wrote:
>> This series is an update for the DesignWare PWM driver to add support 
>> for
>> OF (and split the PCI bits out if aynone else wants them). This is 
>> mostly
>> the same as the v7 series, but with code moved around and 
>> module-namespace
>> added, plus review comments processed.
>> 
>> Since we no longer have the hardware, the clock code hasn't been 
>> changed to
>> either lock the rate whilst the PWM is running, or to deal with any 
>> sort
>> of change callback. This is left to future work (and I would rather 
>> get
>> something in that does currently work) (second note, the hardware we 
>> did
>> use had a fixed clock tree anyway)
>> 
>> This account is probably going away soon, I have cc'd my main work
>> email to catch any responses.
>> 
>> Thank you all for the reviews.
>> 
> I tested the patchset on Intel Elkhart Lake and didn't see issues.
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Great, thank you.

Is this series likely to get into the next kernel release?

-- 
ben
