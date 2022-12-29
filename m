Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82C0658D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiL2NRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiL2NRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:17:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37697BF6E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:17:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 20so5470250plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XB/5UP/6Hlg6zTc+Ud2YT+DViPlugAJ2lyEfvvnjKZo=;
        b=WSaNH1wYnCQ2F4DfK3LHH0f36myjyXNNCEIsNZkta/yfavxOHNCpUlSzOrQwL/vrLV
         X/5TG/lQ4yV2U/NZDmutVlMglPI8WZDfS4Gi1mZ/M9LK6hv0RbU4+626/qrrOChAdT9N
         VTL6GoSUVR31hVmRJKTNkusi5IjqZWAMWiwQSD0alNUCNgjboCsFVkjx6BT2yJnG2s9R
         39j2EoSFIdbU51W7KWOABz5jar/dogLdycBNuuynrzpdxyPsxIz6BXGOMrg7bdAvXDyy
         h3o2tvth78JuiWpzmmXGvBVoi2Yteq3/8rKMG9sOJyJf6jOKB7wHnFBGIMsOYaQNiXAd
         qaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB/5UP/6Hlg6zTc+Ud2YT+DViPlugAJ2lyEfvvnjKZo=;
        b=gARCgGUP46QZkdF9xtAwe9fbg2IupVkKsy2W+sDK243bnDJ0mkox1dGj5QTKfVqx3k
         O5ABttF7XmAZ+6U1Eto4Roux7EXjYBmAGLIirwKsx2gORAPWLeOBbEzS2+/xkRbWKHRG
         U4gezZZKH44UMX62MNcQ1TN1nVBW2gq17VS64A51ygytYrjsnWtr41qoiac0dO/jECFc
         50NhmigcR01KxW+2wCO7AfItCSbfLQ7ISpErBTqoayb2oZdMYtAcV3/yXC9Hxyeq3m7K
         QVxkkDSE/zI+DPleLDkfB74Kl/rNBPWMC6geW9hq5XT9J6USqhRpCsUa7f+yxaKcFoHL
         aEMw==
X-Gm-Message-State: AFqh2kq8QF+zZX/aiOHDY3+697RdW10GrlB/vdeGTpDcwmlwIDXk9Th6
        8Mk/cVNBoCq6MxHoolAe0nU=
X-Google-Smtp-Source: AMrXdXtIST9doYDjZbreinPfq6LLl8u+EjrKg8kUSPl4LiBW+zcgu1u3TK6StxalYI7xvOmgrq9nUw==
X-Received: by 2002:a17:902:7601:b0:192:8e8b:bcf with SMTP id k1-20020a170902760100b001928e8b0bcfmr8590295pll.56.1672319850632;
        Thu, 29 Dec 2022 05:17:30 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b0018962933a3esm12945038plc.181.2022.12.29.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:17:29 -0800 (PST)
Date:   Thu, 29 Dec 2022 22:17:23 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from
 action_page_types
Message-ID: <Y62TYzkpiDxJ7yVZ@hyeyoo>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-2-42.hyeyoo@gmail.com>
 <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:53:11PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Dec 18, 2022 at 07:18:58PM +0900, Hyeonggon Yoo wrote:
> > As suggested by Naoya [1], identify_page_state() is never
> > called when handling memory error on a slab page.
> > 
> > Clean this up before moving PG_slab flag to page_type in later patch.
> > 
> > [1] https://lore.kernel.org/linux-mm/Y2s+dnBsHAJu19ob@hyeyoo/#r
> > 
> > Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Thank you for the patch,
> I think there're a few other places to remove under include/.
> 
>   $ grep -inr MF_MSG_SLA include
>   include/ras/ras_event.h:359:    EM ( MF_MSG_SLAB, "kernel slab page" )                          \
>   include/linux/mm.h:3502:        MF_MSG_SLAB,

> 
> , so could you update them together?

Oh, missed this. Will do in next version.

-- 
Thanks,
Hyeonggon
