Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AC67F57D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjA1HYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjA1HYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:24:49 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A184B6A;
        Fri, 27 Jan 2023 23:24:48 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s4so5947004qtx.6;
        Fri, 27 Jan 2023 23:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgFA+RHMz3Wcfazx0By2hslKEqkq6ZfDH5bkEcW7CJ8=;
        b=k/jyveXDFwleTSKmkxFK634X76A44Lb4wRur1RfUX2tnW6r2CRBEAKM90uiwep7uzw
         BAj9b3I1eIqiNv3nYzBdftTexZYBFaq968m6Tqpj5v0PS7p3gdgu8UM+W/v5yOhljmke
         7XhzjqsZl39FpfJlB7vMZ4/rdQwIr/AeqLS37iz680GonPQveO0NFeg9SP1+BcUP2Qh5
         QWhOTEBP511fweMjml0u1DwrpMjIfyim3+z52rEUv3zSsJDDDWZ2UboLfC8pK9pUjvaq
         L2+M44rnGV/ym2okLU2vJLDCkxDAmg4JIEMiE84/KnzZ+8t+Upa17T/qS1g/dW0StOI/
         pZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgFA+RHMz3Wcfazx0By2hslKEqkq6ZfDH5bkEcW7CJ8=;
        b=DlTVK24JQXFkmINsYtK3ep4A0v8WI4IxfIJHl4lCuq72nY4yaC9DXczBN4FvfN0Tga
         P+QQk19BJ4sI57xy/2J+4nmy3dCnVaXkCrQMurzf3f7tWBdkduL2pktKe9F8zxoUAeJN
         CtoZ5avKHDgPXmrQX4J/TuF5duYUltQFno+3/choDYYDclEruei+2BZF4wi/w3+KIL3T
         j7S4oeMao/Jq1krlmbKtUEnfOW3VcPeRl1jGv+zHPIpY9YCzNv5JZMrO66S0hSmQhqRU
         r9hYJug+0t7F3zIYS6COFlbjQBnXiZHE3P4x6LixwPvPGyJpRnG8XH6sy8biNg4CNWvA
         NK3g==
X-Gm-Message-State: AO0yUKWMxaV2uhRcxoyS68KM8v0aqM/sauDHmqWmj/rwhSUqog7U/qaH
        Z+YKZzfzUCGRhzyXbpYOq8Q=
X-Google-Smtp-Source: AK7set9tUZJxv70jJY/N3WGM7GsCBX6K9dNzFJO9XDT8DWkUBSaqJBrLqCxBIgybfXXCCHd1AoCxnA==
X-Received: by 2002:ac8:5b89:0:b0:3a4:fddd:f8ef with SMTP id a9-20020ac85b89000000b003a4fdddf8efmr2336327qta.53.1674890687665;
        Fri, 27 Jan 2023 23:24:47 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x20-20020ac84a14000000b00399fe4aac3esm4126800qtq.50.2023.01.27.23.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 23:24:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9453827C0054;
        Sat, 28 Jan 2023 02:24:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 28 Jan 2023 02:24:46 -0500
X-ME-Sender: <xms:vs3UY90shyUKWHNBe1rLefHO5HpkHeECYVyUG_FA60KO2pAGWZjd8A>
    <xme:vs3UY0HEjrZt05kEN-J3RIYCovnZsrqrVVesu7nuoWk23VFUdCPp60Q-3ofi_-r0v
    WDCpEGseDJTFeVhOw>
X-ME-Received: <xmr:vs3UY95NaEAAGQ31kG-lNP5K0QdfGUWF6HQi5Hij1XrdtQf9zS8m8mCpb60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vs3UY60H6rMK253CPw2XqyLqpYAbKcEQ5JWRCdTE5wkV3aSc0kuuTA>
    <xmx:vs3UYwF3SjPmSxLxOLb5aCQjxYarUJQXrvDFwME5QDnNMAo9zbyzhA>
    <xmx:vs3UY78tctE5ri8g_8F_UQ1JauMQuhQa6Lg3ZHoGXQ09-5IU130ZnA>
    <xmx:vs3UY73gpbe2oIhXUq875a-Cbl4icB3E_H3WBF0S9qiLhSoRN_vtHQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 02:24:46 -0500 (EST)
Date:   Fri, 27 Jan 2023 23:23:58 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: MAINTAINERS: Add the zulip link
Message-ID: <Y9TNjt7e9uwClarg@boqun-archlinux>
References: <20230127190917.3369037-1-boqun.feng@gmail.com>
 <Y9TH1hQU3eaXB8lc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9TH1hQU3eaXB8lc@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 07:59:34AM +0100, Greg KH wrote:
> On Fri, Jan 27, 2023 at 11:09:13AM -0800, Boqun Feng wrote:
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Most maintainers will not take patches without any changelog text, so
> please, always do so.
> 

Done, thanks for reminder ;-)

Regards,
Boqun

> thanks,
> 
> greg k-h
