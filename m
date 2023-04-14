Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21F6E1C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDNGY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDNGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:24:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353785271;
        Thu, 13 Apr 2023 23:24:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so9807258pjb.2;
        Thu, 13 Apr 2023 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681453494; x=1684045494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Km6YcA36ekb8oNqdHkeZxhn7bUdwM1G05/PfvhODMhU=;
        b=ZpM/TY708GkEDChu6ETatwbXJUy2i1uhgajL/u1YIJp8gpKr7YcDVM3E3/UHn/dwGt
         EeYRWYOv2V5x1URcIrzVpv9+f7BbK+JGTgrksyrOJeQVznKzZVsdhkR03/Dot496K7tf
         FqXyZVDQfycJCodVagcyxxnleKgMSBVP1PajnTljkTql4C3sFurX41UkVmn6oqc9Fga0
         YADY5QlYH9vFCZ0YrwoOwt9Nm0lVlJ95j82ZBTtnoO9tDDLOfR+MfH4ijA6ndLCx44N4
         dWB6HvBWw829XB/d4+Go1hvFI1mpVBoPc9K9uYtu2EjiwFgcuZwXw6+rwMitWLHme+1S
         GDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681453494; x=1684045494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km6YcA36ekb8oNqdHkeZxhn7bUdwM1G05/PfvhODMhU=;
        b=LWo1NkJQ5ZvDc3CJb6VcFX46TUtLq/HBncFYJASG3625qZN+nj9DEr5ReszfifLuer
         CRkXBFF9/qiWIrXaH3rriKdxgR8ZfcHCz5594BlYLvY12GS9MG/U5HChYGgt0Y9U3Dxk
         l2B5+uFIPc5Cqzd8upxUXSHGTNvt1ij9zQc/zzueyDen0xRMGlWNTi/h6Vco30pSUKE0
         SHB+CECECOonkXhFI82Oubqy3AvXzV64n+LJ7dq+5g2If9RDRPvS9PYtoPF9cntBqI5A
         WodRgeHtPDIPrbZtnu83v4aA/m+iRJWWLGmyygt0VCQRozvc8H0hwixhN1OD8pC9lFs8
         2N6Q==
X-Gm-Message-State: AAQBX9dH6Jhv2BtPZCaUG1ap8kI1ESyMJC0uoPhOTBHywOoO74SIvQ90
        E8sVKOYs/5bymiZaTY21TYNzrXtIAy7CHA==
X-Google-Smtp-Source: AKy350b63wJrzAKjC4SCB0BfmSkbxjiWFctM4wpeaaY5NEYPhdRWkOh12Ky0uP6sGl0bbco/ChjY4w==
X-Received: by 2002:a17:903:2290:b0:1a2:afdd:8476 with SMTP id b16-20020a170903229000b001a2afdd8476mr1960023plh.2.1681453494535;
        Thu, 13 Apr 2023 23:24:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5142:7eb2:ace5:60c1])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001a1c721f7f8sm2406220plz.267.2023.04.13.23.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:24:53 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:24:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 -  Modify mismatched function name
Message-ID: <ZDjxsokG+659hWa1@google.com>
References: <20230209040710.111456-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209040710.111456-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:07:10PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/input/rmi4/rmi_bus.c:300: warning: expecting prototype for rmi_register_function_handler(). Prototype was for __rmi_register_function_handler() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4012
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry
