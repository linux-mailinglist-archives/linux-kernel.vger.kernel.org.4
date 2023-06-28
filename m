Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC323741946
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjF1UKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjF1UJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:09:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544301BEA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:09:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666683eb028so134452b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687982995; x=1690574995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgNPZYk/YIR/NjfHGUZee9n0grv7oBxdx9QypAqb0KM=;
        b=WfvYxnUL4Ty/eCmhlk8HZNMz6Ny82a3xTXLYv6oHkr21g+IazJSmxcWT1ghO8tJfPU
         27kszKY5owbTLP6vSwyjzoiVEuxGnIp+cL4sldTr9XSD9Xk0MVC4cM8R5IgK+Bt5lPJ6
         V3dArt47QlGzvaUGxlqrGu84O3Q2USAgm8NOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982995; x=1690574995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgNPZYk/YIR/NjfHGUZee9n0grv7oBxdx9QypAqb0KM=;
        b=Rr9K+UQdKAIDWiS6FqE3Qul6WQP17a0nI2rABcpgjAFGaV4KkKXNWAAvyKVq3fpoNE
         K7jSJ7mjnZTFr9kBQK0X+icBUB7d3H8Fur6BLv0twmzjp/mLB/VolJlO9Kvky0vaZeOA
         zNnjXpDTCPlhMyUdkPlH5oI6xr0prg5js7bkALWCPONOP8/2D1my/XJajdJndyvl9rUg
         G3iFmUmo2zzTDKALjm7ce2Z5T/6EaZx7o4mK6iq6apW+wDYzA4wgVEN1oX7T4LjQK8hE
         4/F9LHFwlmQD8y92aB0roA91LhWaJU4//NXeoZNqaO2nqJujSLI3zWVLnRa9rK/bZh2T
         SVCw==
X-Gm-Message-State: AC+VfDwQrwc8jX6CzTd4h7pQ22DGDPyQJne5ePltju/flAWnX/u3rvQQ
        c+KNRW/cCf8ttJXtxTbzkkaT2A==
X-Google-Smtp-Source: ACHHUZ75rKfbdZ3BSjLldKA1Me+qSORbVApKU+yaiv+WmANBo41nYloYPHc2r1IKD6tjn3/XJ+UldA==
X-Received: by 2002:a05:6a00:139f:b0:676:4c90:ca60 with SMTP id t31-20020a056a00139f00b006764c90ca60mr9924148pfg.7.1687982994806;
        Wed, 28 Jun 2023 13:09:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a62e817000000b00678faa97189sm4869521pfi.112.2023.06.28.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:09:54 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:09:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member
Message-ID: <202306281309.C42CBC1CF@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <e4e881a51a51e6cb2a48d2bdd5feec38c722391c.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e881a51a51e6cb2a48d2bdd5feec38c722391c.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:54:27AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> aac_ciss_phys_luns_resp.

I think the Subject was cut off (it lacks mention of
aac_ciss_phys_luns_resp, where as the other patches mention the target
struct).

> This results in no differences in binary output.

Confirmed.

> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
