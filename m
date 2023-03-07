Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA486AF406
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjCGTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCGTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:12:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA01900BF;
        Tue,  7 Mar 2023 10:56:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0C3423200AAF;
        Tue,  7 Mar 2023 13:46:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Mar 2023 13:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678214807; x=1678301207; bh=OE
        0XkuYckKW+GV/gWAK6SUZf1WFVHEYo5bhdTGgQVN4=; b=W/WGual0eYfv4QKUVL
        WzXz0DTkfhwRa48v6O0kFX9fWqJgTdyzV28j7YxJ2xNZdhWWQ9IyvZi/7wGksTMh
        3wmiAqpcHxMaGTn+PHPi3t2+/tzWq/DpdEVe/slnVdul4jIvd7vGnqrc6mW51o4v
        CkUPriAiyCc29n9FLpeYTjzu0kWbG5MLPQgSfOLT+gcUbIWeqF5bkdjcwI1vzHgK
        iGB4ZOqLB6a4d9+l+63bs6zcyTxGCEfuuUD2TN8SXJq9nQMKBcbIroJtoFCLSI4B
        CyVcUAiXCQUZnhTX+QNc1n/P9w1bNDs63MQt+CpuY5Ms1dq3MUtYcsEfr27A5tHM
        L/jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678214807; x=1678301207; bh=OE0XkuYckKW+G
        V/gWAK6SUZf1WFVHEYo5bhdTGgQVN4=; b=m7TVa4KG6wHKhfGoKLUje2p/HRtb/
        dIlC+eUgh6fs/069UwToTHsgru/89gUSNK5WefYhPHXulsw6W558NBVdzn7b1S2x
        mHQ0FyG2KWy5QbiP1hfg0l/a73zfGSd8cNUQCsVbP7A2FW8wpCDC0v6JlzUzgLao
        G56dhZ7gwo++txP5rInGZn6kXxT1JbQ7Hej2aNjP4VIBznnEBLxF9lNywQeM+hTI
        wBzusSa6cj1D56SAAaWRJQg7dbr6g66UwYiHL60xauur9Wd+YojZ4NEJ0stOtdyq
        s6Y4X7foQfTaiKI68bY9c567x5NqsZOU5xADYMZFQXphtddkm5+20iSXg==
X-ME-Sender: <xms:l4YHZOnTM3RukeqswTV7qdiYgVHWetRK6yzbLaIe4RnnsQqXWmKaBQ>
    <xme:l4YHZF2sNrtnkmUPk5N8x-pFscEpqWcHZKhBM_mKakkvuSbpKANiTBzcdum0lu-ZF
    rgYkwK4tOkYfzBfnQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:l4YHZMpJP1iFESkvIP8z99ddcn5RZrkB0vSnvFvbsVTLtuBdNeWdXw>
    <xmx:l4YHZClTWeaoNd09EhqjuZNCw2JvvFiQ-gP50GijV1CvR24KsXye4w>
    <xmx:l4YHZM0Cz8gN6O0o-KWpV9xJ-YnFJaEMd6_zhxhni46aUZOfQs29OQ>
    <xmx:l4YHZNI43E0lp01IqYSxRV148U9QPOyEONq9CBQDnAqDhGY6UH5gqQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EB07CB60086; Tue,  7 Mar 2023 13:46:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <76be6056-2057-4199-9dd2-52d28bbb37e8@app.fastmail.com>
In-Reply-To: <CA+G9fYvX8W6R6FtxZbCmdeKhSikmdD9Tten8U5qXX4cG3+-1VQ@mail.gmail.com>
References: <CA+G9fYvX8W6R6FtxZbCmdeKhSikmdD9Tten8U5qXX4cG3+-1VQ@mail.gmail.com>
Date:   Tue, 07 Mar 2023 19:46:26 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        linux-next <linux-next@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, lkft-triage@lists.linaro.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: next: arch/mips/ar7/gpio.c:19:33: error: field 'chip' has incomplete type
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023, at 18:10, Naresh Kamboju wrote:
> Following build regression found while building mips ar7_defconfig
> on Linux next-20230307 tag.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Please find the build log and details below.
>
> build log:
> --------
> arch/mips/ar7/gpio.c:19:33: error: field 'chip' has incomplete type
>    19 |         struct gpio_chip        chip;

It sounds like a result of 21d9526d13b5 ("gpiolib: Make the
legacy <linux/gpio.h> consumer-only"). I haven't tried it,
but I think this should fix it, unless there is another bug:

--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -7,7 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 #include <asm/mach-ar7/ar7.h>
 


      Arnd
