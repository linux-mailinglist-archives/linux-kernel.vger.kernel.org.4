Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15968754F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBBFmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBFmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:42:13 -0500
X-Greylist: delayed 12959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 21:42:11 PST
Received: from pro.mxout.rediffmailpro.com (pro152-37.mxout.rediffmailpro.com [119.252.152.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE4103
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:42:11 -0800 (PST)
Received: from pro237-130.rediffmailpro.com (unknown [10.50.252.5])
        by pro.mxout.rediffmailpro.com (Postfix) with ESMTP id AE30D1E17B1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:36:08 +0530 (IST)
X-REDIFF-Delivered-Remotely-To: linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rediffmailpro.com;
        s=epro; t=1675303568;
        bh=3aYpzfR46ETxsZl4KaDC5Ya+CceF6wBc4TleRbgo1dk=;
        h=MIME-Version:From:Date:Message-ID:Subject:To;
        b=YOy5DZ+uknThMvUaSlECvMv7VJBU9vuNOGc6KwGQMF+XaHJoLqGTkcZF6PTuiimBX
         wehlJpgPEh1OJ/dz2AZIfC/dEg26uRWpnGb8FC7ynbjmLGQY8CWrXrBu5XwvqWJj1W
         NQoGxd8UZ37kGtYre2xMScMD+Sbt+YnGPA210t0o=
Received: (qmail 21850 invoked from network); 2 Feb 2023 02:06:08 -0000
x-m-msg: 16d1cfec4566a0b4bc259a22b2cf5661; a6da7d6asas6dasd77; 5dad65ad5sd;
X-OUT-VDRT-SpamState: 1\SPAM
X-OUT-VDRT-SpamScore: 300
X-OUT-VDRT-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucdnodfutggrmhihqdfoohhnvgihqdhfrhdqvghnucdlfedttddmnecujfgurhepkfffgggfrhfhufgtgfesthejredttdefjeenucfhrhhomhepfdffrhdrucfuvghrhhhihicuvfhulhhusgdfuceouhhrphhmthhofhhfihgtvgesnhhithhhhigrmhhothhorhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeduvefhvdfftdelteevteefvdfhvdefvedugfektdefhefgveehfffgjeetfeejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhht
X-Dedup-Identifier: 1675303568_21824_13567_pro-237-130
Received: from unknown (HELO ?192.168.0.110?) (urpmtoffice@nithyamotors.com@102.69.220.202)
  by mailserver with SMTP; 2 Feb 2023 02:06:08 -0000
Message-ID: <d526b012-a8af-6b40-3c7f-34b4b603324d@nithyamotors.com>
Date:   Thu, 2 Feb 2023 02:03:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: dr_serhiytulub53@zohomail.com
Content-Language: en-US
From:   "Dr. Serhiy Tulub" <urpmtoffice@nithyamotors.com>
Subject: REF
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [119.252.152.37 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-- 
FROM: Dr. Serhiy Tulub
Phone/whatsapp Line: +380 97505 5230

URGENT BUSINESS PROPOSAL : I FOUND YOU TRUSTWORTHY OF THIS TRANSACTION
ATTN: DIRECTOR/CEO
01/02/2023
Dear Sir/Madam,

YOUR OFFICIAL LETTER:
Compliments! I seek your indulgence to solicit for your assistance


I feel quite safe dealing with you in this important business.Though,this medium (Internet) has been greatly abused, I choose to reach you through it because it still remains the fastest medium of communication.

I got your contact from the internet directory where i learnt of your integrity and decided to contact you for this Business transaction that is based on trust and your outstanding rectitude.

I am contacting you to seek your partnership in a pending business project,which I have here in my hand and ready to be executed without hitches from Ukraine to your country,I have all the modalities fashioned out to give this business an excellent outcome.

I am confident that you will give your consideration to this proposal and respond positively within a short period of time. As soon as you give your positive response to this proposal, I will not hesitate in sending you the details information of this great investment partnership opportunity.

Regards.

I wait for your quick reply for more details.

Kind Regards


Note: if you found this email in your junk/spam, its because of your internet isp server.

