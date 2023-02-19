Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FFB69C2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjBSWLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBSWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:11:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8317CF1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=zGmQJ2vPS6BIhGFwy8ifbcvPnammdYmvwBXnY3/vnB8=; b=hQACYT1fqsoR/XhBgdLprJxyTE
        kLot4g6rKQ5X6HYtSYNWzVeYKkbjXD1LGey1whPuCxho5vFXkOOQfqfpUoQ1sCZrCNomstoXbY1j9
        CMdk2cDb2T2u8j8SVroHUM9ySktKjEnPaRfFdhB7IWo5hpkm3L/LeBKmOv/E5HAe/sg87d7xyBLR9
        MKFrMdxFtgujNSo7MSRKms1WQiQTXMYSoEALuZIj4vsMvBIOYunP96VT9c0Qodb3rXNrhLL1g9zYY
        5P/h+VVXe4HTQxeQuqcWCkDTom3Ux/Vk1jIFLHB9DlzYlQi/oUF4oWptelWcDbX09NB9zewtGiD45
        1PH09tHw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTrte-002NTz-1U; Sun, 19 Feb 2023 22:11:02 +0000
Message-ID: <7b3b85cb-1a94-5330-9236-ed192c1f4fa0@infradead.org>
Date:   Sun, 19 Feb 2023 14:11:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Bug with /dev/vcs* devices
Content-Language: en-US
To:     Storm Dragon <stormdragon2976@gmail.com>,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <Y/KS6vdql2pIsCiI@hotmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y/KS6vdql2pIsCiI@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add George and Greg]

@Storm: You should always send emails directly to someone as well as to the mailing list.


On 2/19/23 13:21, Storm Dragon wrote:
> Howdy,
> 
> This is my first time ever submitting a kernel bug, so I apologize if this is the wrong place. As per the instructions I found, I first filed a bug in Arch Linux:
> 
> https://bugs.archlinux.org/task/77575
> 
> I will add the contents of the response here:
> 
> For the record, here are the 2 associated mailing list threads [1][2].
>                                                                                                                                                                 The reason why it affects both LTS and current linux is because it appears a security patch was applied to both trees to fix a UAF (use after free) bug.
>                                                                                                                                                                 If that patch is problematic, you should report it upstream to the kernel folks. Maybe even email the patch author directly. It's this patch [3]. Please let us
> know what you find out.
>                                                                                                                                                                 [1] https://lists.archlinux.org/archives/list/arch-general%40lists.archlinux.org/thread/EOSHIVGUZLNAD7BPHSUGOXFYSAFWDYH7/
> [2] https://lists.archlinux.org/archives/list/arch-general%40lists.archlinux.org/thread/S6R6UDUMX2LWL4HJ74MFNYOES45UBFLF/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/tty/vt/vc_screen.c?h=v5.15.94&id=fc9e27f3ba083534b8bbf72ab0f5c810ffdc7d18
> 
> ----------End Response ----------
> 
> Methods for reproducing the bug are included in the link to the bug above. But I will include one of them here as well. As root:
> 
> [root@mjollnir ~]# cat /dev/vcsa1
>                                                                                                                                                                    cat: /dev/vcsa1: No such device or address
> 
> The contents is displayed very briefly before the No such device or address error.
> 
> Thank you,
> Storm

-- 
~Randy
