Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE16BAB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjCOJEt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjCOJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:04:31 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EA1910B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:04:05 -0700 (PDT)
Authentication-Results: mx.messagelabs.com; dkim=none (message not 
  signed); dmarc=none (no record) header.from=nova-world.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+JIrShJLcpLzFFi42KZW/G7SZehSzD
  FYNk8Toue29uZLSb+b2G1mPvG3mJLM5PFq9bDjBYdF9QtNt18xG5x/9RVFou2ydvYLdbeOsts
  0bB2BaPF6XMr2S0u75rDZjHnwFMWi9mdc5ksth+dw26x9d1OJot367ewWpw9cYDR4uqcx4wOI
  h49rww9Pvb+ZfHYOKePxWPu/L9MHp/W/2D0+PdlPrPHxOX7WDx6v81m8zg2bzO7x9Srs5k9ps
  w9wurR1r2eyWP6tGmsHnuv7mL3WH/jDJtH++Ju9gDhKNbMvKT8igTWjJ1/97AWHOCqWLjgJGs
  D402OLkYuDiGBz4wSm5Z/ZoJwDjBKvGyfztjFyMHBLKApsX6XfhcjJwevgKDEyZlPWEBsZgFt
  iWULXzNDlKhJfO0qAQkLC6hKnJz3jRnEFhFQl7h64zgriM0moC+x/+oEdhCbBajm/ZefTCC2E
  FDrnB+PWSDG+0lMufWFESKuLPG06THTBEbeWQhHzEJyxCwkR8xCOGIBI8sqRrPi1KKy1CJdIw
  O9pKLM9IyS3MTMHL3EKt1EvdJi3fLU4hJdI73E8mK91OJiveLK3OScFL281JJNjMCITilKmLC
  Dsavvr94hRkkOJiVR3j9rBFKE+JLyUyozEosz4otKc1KLDzHqcXAIXDj78BOjwJUPn5qYpFjy
  8vNSlSR4u5oFU4QEi1LTUyvSMnOACQimQYKDR0mEN6IeKM1bXJCYW5yZDpE6xejKsX3n/r3MH
  J8+XgGSs/6DyO0XrgHJr9u6DjALgc2WEued2AHULADSnFGaBzcaljwvMcpKCfMyMjAwCPEUpB
  blZpagyr9iFOdgVBLmfdYKNIUnM68E7oJXQMcxAR3HO08A5LiSRISUVANTAm+CXMTCSWbKBg+
  OX6hyP63N6vCueL690I74SN0DGf4b2PsWLVA30Pt3YlYFy877SopGn3cdKYy5ELmm+vr6Q8an
  br7/bDTh3SJntaJvXVkLWXZ5C/JW8E29NSPCtGsj2+NrpnYz1vlsDtn4g+ek8v6ZwULHLrD9i
  t+9Xu62qLC6uJXGuuUGsnl9Mg+9FrTXb5TRWain1vb9yAyRPh+nTRxT2veuMa9pOHhPPOH+ie
  BCpfBjD4Jt+xdxBz7xnta49G5/GN/v7Kf31b/JaUWcc5pRpNZiJNBZKbg+oeHsmus7zSdOmeY
  YXrwlMUA3OsTx5EqnVwH3jlTrO4Quyl2s+Pb4aeUv5h5289f2vGxVYinOSDTUYi4qTgQAhjj4
  9BkEAAA=
X-Env-Sender: jeffynw@nova-world.com
X-Msg-Ref: server-2.tower-640.messagelabs.com!1678871027!67033!13
X-Originating-IP: [157.120.251.130]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11768 invoked from network); 15 Mar 2023 09:03:59 -0000
Received: from unknown (HELO mail.kvbkunlun.com) (157.120.251.130)
  by server-2.tower-640.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 15 Mar 2023 09:03:59 -0000
Received: from SGVSWEXMB101A.kvbkunlun.net (10.2.104.65) by
 SGVSWEXMB101B.kvbkunlun.net (10.2.104.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Mar 2023 17:03:29 +0800
Received: from [87.120.84.163] (87.120.84.163) by SGVSWEXMB101A.kvbkunlun.net
 (10.2.104.65) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Mar 2023 17:03:23 +0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: RE: INVESTMENT PROPOSITION: 
To:     Recipients <jeffynw@nova-world.com>
From:   Edward Stevenson <jeffynw@nova-world.com>
Date:   Wed, 15 Mar 2023 02:03:18 -0700
Reply-To: <edwardstevenson279@aol.com>
Message-ID: <d9ffcc53-7d90-4078-ba85-4aa52cc8949f@SGVSWEXMB101A.kvbkunlun.net>
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RE: INVESTMENT PROPOSITION:

To Whom It May Concern:

My name is Edward Stevenson. I am a Certified Outsourcing Specialist {COS} based in the Republic of Ghana. By virtue of my profession,I have my client’s mandate to source for Investment/Fund Manager or Entrepreneur with wealth of experience from any part of the World  that will be willing and ready to manage my client's  Investment Capital for a long period of 10 years and above without interference from the ultimate beneficial owner either directly or indirectly.

Furthermore, you shall retain 15% of the Investment Capital as your Gratification, Commission and Investment Management Fees should you find this offer interesting. In addition, you will at the same time ratain 30% Net Profit from the client's Investment Capital for managing the Investment satisfactorily. The Return on Investment {ROI} payable annually to my client will be determined by you and finally, you will have a Grace Period of 18 months before ROI will be paid to my client annually. If you are eminently qualified to work with us as specified herein, kindly introduce yourself, your company and what type of business you  do in order to assess your qualifications. Moreso, add your WhatsApp Number for more effective communication.


Truly Yours,

Edward Stevenson,CSO
