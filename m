Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8F694EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBMSK3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 13:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjBMSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:10:26 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC83C2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:10:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 77BE7642ECD2;
        Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6-TR9-K567nC; Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 02E746226244;
        Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0TrPLCqYLqq1; Mon, 13 Feb 2023 19:09:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D33EE642ECD2;
        Mon, 13 Feb 2023 19:09:39 +0100 (CET)
Date:   Mon, 13 Feb 2023 19:09:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        robh@kernel.org, devicetree@lists.infradead.org,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Message-ID: <583160475.125020.1676311779758.JavaMail.zimbra@nod.at>
In-Reply-To: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com> <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: virt-pci: add platform bus support
Thread-Index: cXUPjo4vUqh3hGEi3Rip8t2wqPOpTg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "Vincent Whitchurch" <vincent.whitchurch@axis.com>, "richard" <richard@nod.at>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>
> CC: robh@kernel.org, devicetree@lists.infradead.org, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "kernel" <kernel@axis.com>
> Gesendet: Montag, 13. Februar 2023 18:54:49
> Betreff: Re: [PATCH] virt-pci: add platform bus support

> On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
>> This driver registers PCI busses, but the underlying virtio protocol
>> could just as easily be used to provide a platform bus instead.  If the
>> virtio device node in the devicetree indicates that it's compatible with
>> simple-bus, register platform devices instead of handling it as a PCI
>> bus.
>> 
>> Only one platform bus is allowed and the logic MMIO region for the
>> platform bus is placed at an arbitrarily-chosen address away from the
>> PCI region.
> 
> So ... hm. I'm not sure I _like_ this so much. It feels decidedly
> strange to put it this way.
> 
> But it looks like Richard already applied it, so I suppose look at this
> as kind of a retroactive information gathering. :)

I liked the idea, the patch made sense, so yes.
But this does not mean that things can't be changed.
Until we release 6.3 we have time.

Thanks,
//richard
