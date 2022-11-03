Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912D6189BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKCUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:42:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89291DFFB;
        Thu,  3 Nov 2022 13:42:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id io19so3038109plb.8;
        Thu, 03 Nov 2022 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/hyHiM4b5F/CAQCqJhvgKDL5IPK/b1aY10H+BmVbGs=;
        b=K2sgswnEksfiv5FUPYQVoloU6be56XnLLfHasGnLa51waZ02EGoJxO+HS6BHV1EK0H
         HJ9Whcgbi+oTI7tiM6hlnlbx0yT7PEc/47RHwmdFlpCBaYX+G0iUj/EDm+JLJ1vK5Q0V
         J0NgxZTiBmRrjwdZUanrPSEP2Lx1XhyRsg1hBb7mrG9HNgdLpitW7N+qRgc93G5L+jUM
         GKEE+/KTzJJuuhXIEAtgnkLHyCNkvLJ26IcQdEFdSbqJKZDIOWTEga1Sq6FVnaLS2hUA
         qfEju09DyNXaLJc9cFcLoeTdkf7Z+C+c2hXJMQJlFQhNtk+8OqsFdx9IhLtmHlm3X8Pk
         bs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/hyHiM4b5F/CAQCqJhvgKDL5IPK/b1aY10H+BmVbGs=;
        b=mLJfUzR/Md6E3X+aY+9NQIi+q5lgyseqJGNmMJTiMzbsqGmzzF5cx3H5GYZuUH0yLi
         rALSe3IiUEeVWLPc5l3bytZNJdU/bEWH6WQH7uHdLDyycv2MS9nPL9hLiKAMV8eww8Ji
         piYYBFYez9Ugxr9Bn7BJObYVmhcOE6y05CsCICLob3LzpWhh7aQov8E3sMGKHSfQefMH
         mtukNA3IcT4rcxThjE4a7ZJ28WLEvNSZxbires9W+aKJWHxMdj+QfcfLxy6VQAlknJrK
         Rn+jcHCokZVzzgHyfKvHHEXphX7+16R80pfIE0Gr2eVkApCN3MTVGppFba9kU05IvvNb
         AnNA==
X-Gm-Message-State: ACrzQf2VJqzISmZV0gXyFgHI+jCGS0TouDgDvPOV7WNxW9cey474EHlV
        q0/wTZXGa42bpHAHDOgx9XtWCSs8/Qc=
X-Google-Smtp-Source: AMsMyM6ea8FCAe4ALSuuBBiqUtDGi0ci5CCu3oZz4KtkpjwrGukQ5VfBVZY6Iq6TByNrG3Dg/QpE4g==
X-Received: by 2002:a17:90b:1b50:b0:213:c304:1d2f with SMTP id nv16-20020a17090b1b5000b00213c3041d2fmr28374221pjb.64.1667508132860;
        Thu, 03 Nov 2022 13:42:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b0017d7e5a9fa7sm1100798plh.92.2022.11.03.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:42:12 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:42:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: matrix_keypad - force switch rows to input mode
Message-ID: <Y2QnoaP5XQSA0NKy@google.com>
References: <20221102165747.1528988-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102165747.1528988-1-lis8215@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:57:47PM +0300, Siarhei Volkau wrote:
> Some Pin/GPIO controllers can't get current GPIO status when interrupt
> mode is set. Specifically Ingenic's JZ4755 always returns status at the
> moment of interrupt.
> 
> The patch tries to fix that by forcibly setting pin mode to GPIO input
> prior to reading actual row status. enable_row_irqs seems to set
> interrupt mode back as it should be.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

Applied, thank you.

-- 
Dmitry
