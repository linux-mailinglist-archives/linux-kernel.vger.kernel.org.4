Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375762D399
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKQGuS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 01:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKQGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:50:15 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61395CD3C;
        Wed, 16 Nov 2022 22:50:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0BA0063E5142;
        Thu, 17 Nov 2022 07:50:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C-8DFjzXAIMN; Thu, 17 Nov 2022 07:50:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD56263E514E;
        Thu, 17 Nov 2022 07:50:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SXXDuArp9_Qv; Thu, 17 Nov 2022 07:50:08 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 868FA63E5142;
        Thu, 17 Nov 2022 07:50:08 +0100 (CET)
Date:   Thu, 17 Nov 2022 07:50:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Golle <daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <271114315.250800.1668667808308.JavaMail.zimbra@nod.at>
In-Reply-To: <Y3XN+fDTjHz09qEE@infradead.org>
References: <cover.1668548123.git.daniel@makrotopia.org> <7526fc5a461a0d68eb1dab575f9c1950638fc21a.1668548123.git.daniel@makrotopia.org> <Y3R8oQXRQ8uq8p4P@infradead.org> <Y3V9/pmHs7ypE7lb@makrotopia.org> <Y3XN+fDTjHz09qEE@infradead.org>
Subject: Re: [PATCH v5 3/4] partitions/efi: add support for uImage.FIT
 sub-partitions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: partitions/efi: add support for uImage.FIT sub-partitions
Thread-Index: ujVCwDZmDXzDbx5XljCrk+OdLhc8MQ==
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Christoph Hellwig" <hch@infradead.org>
> On Thu, Nov 17, 2022 at 12:19:10AM +0000, Daniel Golle wrote:
>> While weirdness is certainly subjective, uImage.FIT is not just a
>> random image format but used by a great majority of headless embedded
>> Linux devices out there. It's the default image format of many of the
>> SDKs distributed by chip vendors such as Allwinner, Marvell, MediaTek,
>> NXP, Qualcomm/Atheros, ...
> 
> "Look see, my weird format is used by all these companies building
> crappy SOCs, it is not weird.."

Well, FIT is not something strange invented by SoC companies, it comes from u-boot
and is more or less a de-facto standard.
While I agree that using the block layer for partition parsing is questionable
I think supporting these images in Linux is a worthwhile goal.

Thanks,
//richard
