Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295385E88A4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiIXF6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:58:31 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 22:58:30 PDT
Received: from chywmqxp.webtekhosting.com (chywmqxp.webtekhosting.com [194.87.231.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF8137935
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=webtekhosting.com;
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-Description:Subject:To:From:Date:Message-ID; i=mil.duk@webtekhosting.com;
 bh=VYUg7O7oXMCifs92rLRXtifZQV4=;
 b=OLLVldh7Ds6IHWHUp79KC9sPUvKWLU83iVJ4BEsBk3H+l3O4vtUDIx3RXsGO2cqYBeKaCEhMCDr8
   SD6GLOh4mjOcpL3e+4+RX08mROgoPly5diDPAAsohW7LHfXEcbwTILZCcytuBDjsQZ5ZPpaOwevK
   6zTsp3qOPdzP3wiD628Vsw0xtXOSkh33OTGGidPj1GdvMHv6mrz3ry4N12xVcVKvdP1OAHigly+B
   zvKavBPl5M/poCgQ0QDMvwakfywaz/2HwqloROBxfOAm/PkmsF3lHp5oZsqIHfrSIlbIwVqGMxvN
   oq0CogivH5uiyY3HIbsE/fpqR5YypGH5V4Wfxw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=webtekhosting.com;
 b=lWFEILofcEkjIdcltYpl0E2SNiGozafr+2qPPgt1eTFlQEKXcFHSJlwxmWKCRgyMgxZ7P0GWv+eZ
   4tmM2MCR7rD5QTbYPyMPV98Put5mxSKHQLNdpbaYHygMPPSmckqmKkG8RlPjzQ3L9p1QKB8N8ueK
   lHHxqMuSc1+jfDeGJdVKem/Kew8lz1y6/0Cszgl99eYeoc946k4O0TNPgs0eHK6HQh19eCewqtmH
   FvQHtQ10F6Ez04TfO4C3SkGBIJZMXgVtwGiz251j/FmU2fSvbqhKrOJO3VTtnylLPvtwZCS9mq9u
   hCKjiY098IzhPYY0p/k/NFt26WsqJBuxePgv1w==;
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Business Insight
To:     Recipients <mil.duk@webtekhosting.com>
From:   "Alek Brian" <mil.duk@webtekhosting.com>
Date:   Sat, 24 Sep 2022 07:28:23 +0200
Message-ID: <0.0.0.27D.1D8CFD6798B9EC2.0@chywmqxp.webtekhosting.com>
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,
        URIBL_BLACK,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: webtekhosting.com]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [194.87.231.164 listed in zen.spamhaus.org]
        *  0.1 URIBL_SBL_A Contains URL's A record listed in the Spamhaus SBL
        *      blocklist
        *      [URIs: webtekhosting.com]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6747]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [194.87.231.164 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  1.0 TO_EQ_FM_DIRECT_MX To == From and direct-to-MX
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Alek Brian, Researcher at a reputable company in the United King=
dom , I would like to share with you some business insights .

Please Kindly reply me on my personal email alekbrainpharma@proton.me

Note: You have the right to quit by the end of my detailed explanation and =
you don't feel like moving forward with me.

But Trust me, you won't regret it.


Best Regards
Alek Brian
alekbrainpharma@proton.me
