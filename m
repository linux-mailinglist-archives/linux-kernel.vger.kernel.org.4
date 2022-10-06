Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96D5F662D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJFMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJFMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:36:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADD85AB4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:36:45 -0700 (PDT)
Received: from maud (51.sub-174-199-42.myvzw.com [174.199.42.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E430F660230C;
        Thu,  6 Oct 2022 13:36:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665059804;
        bh=ivBODqB8zT0i8tsODwDmN95hLNFD02EONqwIrD/T+bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jO3XfDiPepr8diAmDbe/VoloJDamezcRbDNea09v8fiCCGPC1jsROz+FNkzRjt+Yp
         dew6CZnJPo+vEjqtN2AtVdVoVIrnSj4hQHFLVD1tF50xJnvh1uiQtyO+uxrjymmhzj
         L76r0TKAWx5gEwzF4nLw14TfCdJnD4MHhObaTfqiQJIr3uPfLkdYv79g48+iriOKtv
         XlssrXjkFrWycBDh2PhL9xa5kjQuXivVw8wUh9x7G6tuGa2RnkIsU0MbpTKDZ3gRhy
         mhLHvQnmQRhQma8WcWJE7Yz4owLXIX3dvDZdfXRPIbfRG+TEdKqN3Gqg8qiBRrUE5e
         q+ipvmcjCERSQ==
Date:   Thu, 6 Oct 2022 08:36:38 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com
Subject: Re: [RESEND PATCH v3] soc: mediatek: Introduce
 mediatek-regulator-coupler driver
Message-ID: <Yz7L1lwl+uNQWnjd@maud>
References: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@collabora.com>
