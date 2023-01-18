Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C919672548
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjARRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjARRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:30 -0500
X-Greylist: delayed 83370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 09:42:02 PST
Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC837B5F;
        Wed, 18 Jan 2023 09:41:49 -0800 (PST)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id E9FC818000A4;
        Wed, 18 Jan 2023 12:41:48 -0500 (EST)
Received: from pappasbrent.com (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-11.privateemail.com (Postfix) with ESMTPA id F33A018000A8;
        Wed, 18 Jan 2023 12:41:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674063708;
        bh=D7WHsXyXqtqJWxl+4AA+cbRa4gc8zNjQxP2TO71jpHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKJ78MCIj8RQxUTJAJzyJonlBSXjGLX/1+BIy3ysTyJAUyYB/JdRj1e8GYa8zQpMm
         LNyfGg4qG/ukz4it8cTkmkqAFu6+jyq7YIG6GxfyN2tO3FNAjOPDPlho52sDRE5aQf
         Hru1Ri3XaDd8jgcsGf5xfoeswQDayvWcwmMlN/k6F5MLM223SizJPaTTsIZus5kLbQ
         LBVGoe6kpGBNBeHU6FJcM3USIrtPpJSZTPrm4eYxpn7G/f7y8NFJVEEqhVPbok/MRq
         d3C43QpdkqcK9K3UPktq7NoGYG9WkZPq5A30lghDkQKwLyIu3+PIXlWgx+U1v59Fk4
         o7/uLItoaMO4g==
Date:   Wed, 18 Jan 2023 12:41:36 -0500
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ailus@linux.intel.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH v6] media: atomisp: pci: Replace bytes macros with
 functions
Message-ID: <Y8gvUG6ncjZ0WG/v@pappasbrent.com>
References: <CAHp75VcxvPZOZpGMSQXkCFv+WekHckMJkympfdR0ih72AjjkNw@mail.gmail.com>
 <20230118160739.26059-1-bpappas@pappasbrent.com>
 <CAHp75VeP42nhAnjWMXnsHpd7SQhJ2G1kqX6mbEHxnpFHhKWYHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VeP42nhAnjWMXnsHpd7SQhJ2G1kqX6mbEHxnpFHhKWYHg@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In my MUA I don't clearly see if indentations are really being fixed,
> assuming that

The issue I was having was that my editor had tabs set to size 4.
I switched them to size 8 and could see the issues that Dan was seeing.
I've ran checkpatch.pl on the patch and it passes, but if you see an
issue I will address it.

> Thank you and keep going!

Thank you for your patience.
