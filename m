Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8962AE64
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiKOWdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiKOWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:32:36 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A77646F;
        Tue, 15 Nov 2022 14:32:25 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5AA2337E;
        Tue, 15 Nov 2022 22:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5AA2337E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668551545; bh=PdFm94su9VZgxM6b1Gu782P+u5sWIDNgRPljofJvb1E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XxKGH3b2U+XLrwyUrfOTKLYIi8iD0ZWXJTnPPdCXnPsxt3Qyyh3GW+hm+GD0ssmgQ
         BqmlXlylVPDC2FKRCaXTvay2bv0pLeJ/EsXR/D/bmti6NKxT9dOKYdD++Cz1ooOHOF
         s5/SeqBoWB3WxV4nhemTx9MVbEUhBMauHeAo97qO1w3tYo9KBooFZVv8PosopulAt5
         Vok4aMGGHvsF62gWfYvJbdSt2nXei8EY0/ldFFN8ufkY33GjUkQPcdvtqqMOCUN36X
         XG+y8kr2uErO2/+KjTBwHQCxQ9IHtFTLp3CnbDPu0z++f1owfxBZMaEL1zZnxIATXA
         q8cX3xA3lD/Ng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] docs/sp_SP: Add process submitting-patches translation
In-Reply-To: <32bdf227-66ec-adf3-23a2-bd4e09bdc974@amd.com>
References: <20221107150815.296699-1-carlos.bilbao@amd.com>
 <874juzan8v.fsf@meer.lwn.net>
 <32bdf227-66ec-adf3-23a2-bd4e09bdc974@amd.com>
Date:   Tue, 15 Nov 2022 15:32:24 -0700
Message-ID: <87y1sbkfwn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> For what is worth, you have my word I am not an evil translator trying to
> ruin the documentation.

Good to know :)

> By the way, that's exactly what the English documentation did for me. Did
> you know that my first ever commit to the kernel was on the documentation,
> and you reviewed it?.

No, actually.  I try to notice first commits and send a congratulations,
but I obviously missed it this time.  Looking forward to lots more!

Thanks,

jon
