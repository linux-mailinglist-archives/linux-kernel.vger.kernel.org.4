Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C91671BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjARMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:21:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD459774
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:43:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w14so31922098edi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVdJXkBT1u1Qr9qo5crqp1GKDUin4aa4fvlizwpu6sU=;
        b=bNPCx8m+jjgbZGPFsps17MmHnLLQzJU14HFS8k18ZCB5sOFJg0BLzO0YwWWwj5Y/m0
         ekMAvDn67UAiBzFbT1SnU1ofaQfE+JLVHOW15Uj5ghzUOW/cfaUWyFR3Zz6yxVB2UZjd
         MdL3380gx5beuuoYukrsD+04aEGno9GaLeN1fHp28aZtRgPUo3fZqfL5aSqKaAafOJyt
         wPBU8aKfO5Ljdzc6aJU3QkXn5OGtl9QugfVghlqPdp6ucrevS1n4Hs5JzMStPRc4ojHr
         GpbPQ/FP+j+5ZuZO+eA6Hafs8WEgf25sGJtzJ4zffFLVmYnPVBCs1s6xS12e/m9aN8nu
         gjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVdJXkBT1u1Qr9qo5crqp1GKDUin4aa4fvlizwpu6sU=;
        b=z0mnwzSFpSM/WK2TivEzOxdyLwCyAUgFQrKJDmkMFfrQHBpe8HZrgkZ/+uguCMMw2P
         6PNL6/ZhPRlOXWg1vrCjDHCGGf/683NGDcLUHNtYzIdVc0Fu32mtceAcUww2BiNTCXwL
         PTr+ui7NZLL3AQQBlNJ+xC//bgSPanw3dKESRqICLHXM9sM0EbLGkvx3TdNiXdLFhsXw
         X95T3xrQrmwm5yFvae6BdtBRoukcB0NBJfF5qCSbxX1ax0CNu8QLXvxX7KfnbBkS/hd8
         O+oDHdU6MWJiuKlmWYepKTS6UX7EGX5/iR6T7TgVM6ChrsbHbGsryaQIKsNByQeCJcRW
         v+1w==
X-Gm-Message-State: AFqh2koYc7wFyRbfx/o8hXk7knzUx+W8oNkyy8+FFhiKGxXjJjJMxMRm
        dwn0TVCfl9N7BC9Vbjyt7vRW4NNwbJo=
X-Google-Smtp-Source: AMrXdXvgQFeDBVuwMJ9DNFFyzsHZpT4+bidb5WKFocb8QwjVhsQkAjVhGmINSebn4oAtFIWiUkeIag==
X-Received: by 2002:a05:6402:388c:b0:497:1787:13af with SMTP id fd12-20020a056402388c00b00497178713afmr6891030edb.32.1674042203359;
        Wed, 18 Jan 2023 03:43:23 -0800 (PST)
Received: from gmail.com (1F2EF20B.nat.pool.telekom.hu. [31.46.242.11])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7cb01000000b00463b9d47e1fsm14008765edt.71.2023.01.18.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:43:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Jan 2023 12:43:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/4] perf/x86/intel: Add Emerald Rapids
Message-ID: <Y8fbWV+FVFgZr4sn@gmail.com>
References: <20230106160449.3566477-1-kan.liang@linux.intel.com>
 <7760ae92-e713-603a-217a-25035523b1b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7760ae92-e713-603a-217a-25035523b1b2@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Liang, Kan <kan.liang@linux.intel.com> wrote:

> Hi Ingo,
> 
> It seems that only the last two patches of the series are merged into
> the tip.git perf/urgent branch.
> 
> Could you please take the first two patches as well? They similarly add
> the CPU model number for perf core driver and perf cstate driver.

Ok, done!

Thanks,

	Ingo
