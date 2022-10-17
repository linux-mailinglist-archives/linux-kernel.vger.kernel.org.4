Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56C16016A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJQSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiJQSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:52:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADF75483;
        Mon, 17 Oct 2022 11:52:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw14so11790655pjb.3;
        Mon, 17 Oct 2022 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIdkwspDRTxBMb690bkaqp65gj7uF4RV7RH7SZAj3xQ=;
        b=lwVPu73uy/vBF1dt6N88JhivmkqFJxKfaA3I/rUK9xqCHP71hJiVoRKERCks5GfWvB
         xi1OcWi55CGfTExHaNBIuDE3sfzzrKtQW4on7RvoCNpM1talj2LpiqCgviJbQOTt3uqi
         QknMrDXfnxFeQ/bPbE6SMkuzttUEs1JRRJwND9kOT3yMrzd/66javsxf/LTbCB5OyWrs
         9BV7qByQ/blOSAQSxrG3P21Znc0BQD70h6k4mPF6IETf7T6Np3/sP3DGGrtJkPGX/0KO
         LnllMrhJa+yxeXwuCPTDuE+Lzi2p5St3mdOn56+hIxm6SWkvwA5S4NwH7/bS5FO/iy2E
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIdkwspDRTxBMb690bkaqp65gj7uF4RV7RH7SZAj3xQ=;
        b=gl/M3++WssJB5oJoqAgUgmLVDBkVe+XOvmHvnkGPqph83gHYHexh/1dS5Rb41xxkjC
         9+ancv+W6QEQnjzLckbn08xaqfNZrRp9wzCfhnuIa/4evIqUghwdVn/I6UH4QYT81YOd
         Ge47n3xkDxa+UUempOJVK3T35aERxF+B0X7FKDMMhAua8jUbMl4MTzrHSNiDZvEbm9N/
         OArk1x+BmZFQ95Ao7w6bkQmnO4ifQE+9ySB3gqY/hUQRte/biOdFZuRfaZdRvM7GkkiB
         KICqMauz2jvX0z4dFnv8AgoulanEdro9Tnf+TyPKBFDrgEHyNBUvs5lX/i+FVAJxUlMY
         aY+Q==
X-Gm-Message-State: ACrzQf0d3PeoWda4ZK7sRh0YZ810OTCucXPdYnKqtdUE20zVtcqBkEkn
        iJ62bycS9B4lnv8p/7Yyt+M=
X-Google-Smtp-Source: AMsMyM63Sreo/PZBmsJ/qveiPJm3l9ww2KXckUeQ77J4GRMDugcak575wxjhjaWUE1shdwODx9nsIw==
X-Received: by 2002:a17:902:8212:b0:182:2f14:f6de with SMTP id x18-20020a170902821200b001822f14f6demr13412181pln.38.1666032728198;
        Mon, 17 Oct 2022 11:52:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m20-20020a62a214000000b005609d3d3008sm7709695pff.171.2022.10.17.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:52:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 08:52:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-iocost: Fix typo in comment
Message-ID: <Y02kVoo2hJPJEerg@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-2-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-2-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:04AM +0800, Kemeng Shi wrote:
> soley -> solely
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
