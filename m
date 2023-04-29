Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331696F2700
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjD2WcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2WcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:32:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C711B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:32:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DE10E5C00C4;
        Sat, 29 Apr 2023 18:32:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 29 Apr 2023 18:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1682807539; x=1682893939; bh=WEXQivD/BHVkDjdwhyPJPNlkL
        4e8FVWBLGqE8gJtSsk=; b=AITKlBdl/Y0ka7nq0Rumwudc/8y+x4X7biXyxCOx7
        sNVLfS/Yj3S7vDlHi7zJ5Bezo6RGFhuk9OjLLx3old/JjEQ14r/PleCawPP/ttHe
        wYWgmOHopl3e9thpXhQ9uKttHH/mx8DxQVJsspNjOIHXQhgiIVf3fHTshdto5MyE
        wAwe0OwH+lsGQ5eQ8RI6Ksq2dG52msDOCNQI2adbpFRCbaNSQ1+8Gq8vUAWqY+SI
        vHzRsFzjc8hPgKlAlfyC3Mfo/6Ztul+UhJRYpspxYgryPuiZocEeBZmTrIvj+Cy9
        zgqePm1BWHI2UzUmdWCM2x6hJhT8Psxaq5al4URbaItag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682807539; x=1682893939; bh=WEXQivD/BHVkDjdwhyPJPNlkL4e8FVWBLGq
        E8gJtSsk=; b=WlEC/MmcGC7H6mwvlac+8ILM6wx/H+6NZvFCJeyUm/KEOEFg52g
        +PA4gEHWD6yV+yp7cLle/a7rQ4dZViXOZJtkdISK8xdRIrkuiqyC8PEdk3FtBiRQ
        iuSJ4RYjHRzR1Y4GJq8eBr/ZI9uTCNlhEvb35Ok9Td6U+/EfwL+5njR2TalTvEOv
        EksVT+Fz0V+ozwjjx4sQkBc4tUIpvL5jE7QPhTBBjB/XiJB8L/oJggC3yceCCPjN
        IdGiFEslNFGJoxGIwU1oB3nYLvwjzXRjl+4hU18/lombR9AdoRW1/h4FUnf0NKkS
        DPMC6+ER99dHOvBqqGNEyRzwLadliBgVNuQ==
X-ME-Sender: <xms:85pNZO7u4U6lB_zJ9ZsmDWMODpPuvvhjWQYkGA1azMTQPxz4sayxgQ>
    <xme:85pNZH6rOoJq4lv4ozmPWkbcl1BqJ24CC2NR4N1T4F0RiahHQcOWu_Siia5x1w78n
    o3SA-0daMwp1okpqK0>
X-ME-Received: <xmr:85pNZNeQlnz2B2MMzxPs5o03N1HbGmzbwqPZUytfkqD5X0GiReXXOspN8tt95MRCIGJp6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkffogggtsehttdertd
    ertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpeekjeetteegtdeifeejjedugfduvdfflefhteduve
    ejfefhkeekvdelgeekfffgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:85pNZLJBVI-jJ2VmJ4FkZUqmnXNWe_0qFJuJV-YBn2efPKIbzT0eYg>
    <xmx:85pNZCKpQeKHcdlBRCl6vg6dfT-0usSnMWyq2JBuX6CU7_kVJhCcmw>
    <xmx:85pNZMwrKDwoqXMQgLXlcFZCfZn6PdP8ozkcKLgV_nISXh4OKS9Jlg>
    <xmx:85pNZBmQDbU5xiJWxeMvTyieT97rf6vPbLqCgcWaQ2CcvIZtMxhfLA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Apr 2023 18:32:16 -0400 (EDT)
Date:   Sun, 30 Apr 2023 10:32:03 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] drivers: fix keyboard not working under some laptops
To:     hqp1203hqp@163.com
Cc:     linux-kernel@vger.kernel.org
Message-Id: <FLEWTR.R6BA7U7SGOH71@ljones.dev>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Because this is a quirk sepcific to the FA507NV:

 > + .matches = {
 > + DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 > + DMI_MATCH(DMI_BOARD_NAME, "FA507NV"),
 > + },

perhaps the patch title should be renamed to reflect that?

I have a user with the same issue, I will confirm it fixes the problem.


