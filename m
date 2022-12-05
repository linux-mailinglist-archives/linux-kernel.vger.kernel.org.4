Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4065D642661
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiLEKIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLEKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:08:49 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87433186E2;
        Mon,  5 Dec 2022 02:08:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C5432320095C;
        Mon,  5 Dec 2022 05:08:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 05 Dec 2022 05:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670234924; x=1670321324; bh=0cWFVn6Jt3
        0KZzilLG6w+rtzharMgZZo8y/FqB4OzOA=; b=Zv5G1sT9cy0RGrWmakbzz7t8kU
        bA+vyob5lMX6WCVoyORHcMMUXhde847YKIqEG091niEW6TYOdRjXTf24YMVtVipz
        XDCW1d4ZYtFc8SSRvZwIo/dUzGtBpTXi2qwBI0t50coDJ0hyEpdAJvGkpg1HkvN7
        lHIZZijn4E1ehJsOnCGy6LXbtkZpehJoHaHy4tPPkb1mW12483Q86Fcxd6EPqkaY
        lq5e8tgA3HiRoUgi4+QUlWug8EOveg8WZZjRjLtLWZSzESKlJWia7l2Z2s1e0Eii
        qXL5KH6DvaHTNKTi7snIqkoKViNbrszV8ol2+3bXA+xZSlGEYlYq5934Bl6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670234924; x=1670321324; bh=0cWFVn6Jt30KZzilLG6w+rtzharM
        gZZo8y/FqB4OzOA=; b=D/ItRqorHzrPrPzwi2cYbUYcrIqshcxgThxeCJkzEKY+
        ONmON1oN0P2WCJRtUSCaIwixWmma3jIiWjrfYD/HR6xIhIQ0LgF2tWmnVP6PCtYf
        u18t/t4JbjwrbIcerOO2S4zYXABG0wY34sTPhFTb5IbZB0Xt4VtQpPpq3ND5l8Rm
        X23l5tzCVYYJCkvwuMB2JJsYBzS3bRHlurN6lpUH6bcWRr/T5RWFz2wFx/3q+zsC
        hgoKNjGdDrRaqM+xpFrxVIbjCPyq3xjwKF+vxowiJ6sZQRaCCTs7FNWlCYnNJFV8
        edVBaHO/SgNxBDzP2l9Oc4ApjCsG+UjwqSOaNv77Xw==
X-ME-Sender: <xms:K8ONYxR_bMWuZ-LPDyUi44kAzv1qioRosgPqN1mlJHjyin99Jn7Jog>
    <xme:K8ONY6wvxE-MdNbBf8JWi5mCmC90aIdcPhDbPj5ktFvyvIz5IqpX-bGrYBhqovUPu
    9tbHYTODOT8ERzx8fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:K8ONY20sTUvw-Ju7NQqrC-YopIVaOH-aAvFqYSsJX7Inr1pVC-zOnw>
    <xmx:K8ONY5BEJSVRlu1xEOCaE53VYBWJBdlIs38TZofQLoHFg4f6CVekOg>
    <xmx:K8ONY6hVe50Rydg4P4djbiSou2YZKejE56An9mD-ySVoGbclHnsoeg>
    <xmx:LMONY7bE7gl6lLYvGx07rvgVwjlHwT4IqSwpYpPCXt5KPQFJ6UnN4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5DFCBB60089; Mon,  5 Dec 2022 05:08:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
In-Reply-To: <20221205011105.4do4trbytq4bfw5b@mobilestation>
References: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
 <20221205011105.4do4trbytq4bfw5b@mobilestation>
Date:   Mon, 05 Dec 2022 11:08:22 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Anders Roxell" <anders.roxell@linaro.org>
Cc:     "Niklas Cassel" <Niklas.Cassel@wdc.com>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        "Serge Semin" <Sergey.Semin@baikalelectronics.ru>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Carlos Hernandez" <ceh@ti.com>,
        "Sumit Semwal" <sumit.semwal@linaro.org>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022, at 02:11, Serge Semin wrote:
> On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:

>> 
>>   for (i = 0; i < hpriv->n_clks; i++) {
>> - if (!strcmp(hpriv->clks[i].id, con_id))
>> + if (hpriv->clks && hpriv->clks[i].id &&
>> +    !strcmp(hpriv->clks[i].id, con_id))
>>   return hpriv->clks[i].clk;
>>   }
>
> Indeed I should have taken into account that devm_clk_bulk_get_all()
> can get unnamed clocks too. But checking the hpriv->clks pointer for
> being not null is redundant, since the ahci_platform_get_resources()
> procedure makes sure that the array is always allocated. At the very
> least you shouldn't check the pointer in the loop, but can make sure
> that the clks array is available before it.

Do you think this is otherwise the correct fix then? Any chance we
can still get a version of it into 6.1?

     Arnd
