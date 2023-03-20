Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F96C08FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCTCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCTCpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:45:24 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Mar 2023 19:45:23 PDT
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8759EC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:45:23 -0700 (PDT)
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 64476A4E;
        Mon, 20 Mar 2023 03:37:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679279856;
        s=20210208-e7xh; d=mailfence.com; i=jamesharkonnen@mailfence.com;
        h=Date:Message-ID:MIME-Version:Content-Type:Subject:From:Content-Transfer-Encoding:Cc:To;
        l=1227; bh=5cvYa/FDQqm0EEyGeluDxtsuU9lI5XIm1bGriL/Q0+A=;
        b=aWdu4YGqk0tRNaLqYUU9HZn7CPjB2Up6Qd8atdH9GfP1VCSXbTRl7ANaOCuykEK1
        shcqFCeskoM28de3VUTe9E79ORfDuM4EDFpKDuZUmTkQyWmttnOU1cQuskK/Cc05onk
        QjdU9Vjwj4n9D7Y84mUMzpybMVjiZ4WlybqD0P6B6SLUwduurL6vRSLDXX2klDU6PXG
        GS/ISa+ST8v0lwjqMo/X+73sNlTaK9o0VFeXD8qdpUZ557yCXycW40+OEr2HIYxff/7
        9rvtHSHXR2aYNwLg4bxkUqisZb/xISwhv7vpc+HfICEFqNRJMvzFpu3hNxGHXXr//PE
        sqX+d9/Bwg==
Date:   Mon, 20 Mar 2023 03:37:33 +0100 (CET)
Message-ID: <1436328866.1669928.1679279853556@ichabod.co-bxl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [RFC] What is the official statement regarding Baikal?
From:   James Harkonnen <jamesharkonnen@mailfence.com>
Content-Transfer-Encoding: 7bit
Cc:     linux-kernel@vger.kernel.org, fancer.lancer@gmail.com,
        kuba@kernel.org, gregkh@linuxfoundation.org
To:     torvalds@linux-foundation.org
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:423462028
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously in case of University of Minnesota there was an official email explaining what's going on and why the certain organization has been banned.
In this case there is only random bits circulating on the internet.

----- cut-and-paste from original email -----

I will not stop any kernel developer I trust from taking patches from Russian sources that they in turn trust, but at the same time I will also not override anybody who goes "I don't want to have anything to do with this" and doesn't want to work with Russian companies.

And yes, I realize that you will likely feel this is hugely unfair, and that you had nothing to do with the insanity of your country's politics and leadership.

But I hope I have explained why I don't feel like I should override any maintainer who feels that they cannot work with Russian companies as things stand now.

----- cut-and-paste from original email ends -----

Would you mind confirming if it is genuine?
Do you have a list of potentially banned or affected sources or organizations?
Will the patches be accepted if sent from personal email addresses under different name?

thanks,
james h-n

-- 
Sent with https://mailfence.com  
Secure and private email
