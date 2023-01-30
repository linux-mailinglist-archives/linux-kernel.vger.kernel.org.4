Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EAD681666
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjA3QaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbjA3QaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:30:05 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6E43903
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:30:02 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e15so14689129ybn.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoLH3reILvg5UVXU0ViAEu7dA7E4/FUTiJhGYqbHLag=;
        b=JvovbOEiurqKGKaZhU2wemRT5er0dvcPAJ8Oyt1QHHlgoH+mDwsz7Kex9v0WUqBK7/
         2XBOTku+YhdryYTMfPMCZcpJHBaHS5bU5SWyxFQYxjPFil+lPv7bZ6S57tS97gc5jiLp
         xEXnkW46XyXyeHpeRkVriP2wvFOo71ICa3q+UTODbvv6WhAV6TWKtULk7/nMtK2KuSEV
         bOU6D8jNbojMDToEAQHxJC19COfYXNBUD2uGSLV+VyRP5WsSspOp/VMF4hBnixh9PxY4
         UxTRWnT4pWq6v2Z6RNkOGXDJ/nArI6KdpFo8QJPwfALO8bY2pbi/iFlupQQFXBHfWw/B
         /OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoLH3reILvg5UVXU0ViAEu7dA7E4/FUTiJhGYqbHLag=;
        b=TFAIGUnaEO0dx88cS8auTX4FRt0s2SziIDlSCv3geVomDucjrDtdK0Q+Eqt2sis62e
         tL3ZIm1vH6STlGI1PI7S5+ylworJs9MnCIcA6NwZtCwfK7sBCU1JU7HYFR9La86lRmxr
         TCJili4d/s7QbxIa1a7bMXCMbfRQhsttWEIeCAl16ZiWa380UlC2FPMX19b6m/AlXliz
         WBTWhsg3JulneQ+HcKDJZX7iE3LkePvXoubxreCDcP8s+CHpOYfKbf3os6QnPJs+HUqp
         +Ts1DTklbTOQaT1oY9aRa9iBtgTsxmxffA3XRZ9xRUHTzA7DjUSBsRso1EqAka5h5xcJ
         BaLg==
X-Gm-Message-State: AFqh2kri0LagbT7h+AgOgmMwwWzd3LUqs5wN2Muied+lwHzRKnv6quMb
        BhAhprv/h1WgVCPuuJMTiXtXRkoh1h6FCAuv1unS3w==
X-Google-Smtp-Source: AMrXdXvEh4f28D7UERcineZdxy+w6tqcZMWpPWqMrL3XsVvr7822ktkTlmkQdg/CndeoBp2VW6Bo0kvA2kTRk4CZpqA=
X-Received: by 2002:a25:7c47:0:b0:7c0:46a9:5e62 with SMTP id
 x68-20020a257c47000000b007c046a95e62mr5513768ybc.245.1675096202014; Mon, 30
 Jan 2023 08:30:02 -0800 (PST)
MIME-Version: 1.0
References: <202212051324.182a6363-yujie.liu@intel.com> <CALvZod4CD+O7-ynGAHU-6vxE6CbSmuQei1=SVJsx0zFfQdmV2g@mail.gmail.com>
 <875yepfe4j.fsf@yhuang6-desk2.ccr.corp.intel.com> <Y9ctU3HtkAC7G05Q@xsang-OptiPlex-9020>
In-Reply-To: <Y9ctU3HtkAC7G05Q@xsang-OptiPlex-9020>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 30 Jan 2023 08:29:51 -0800
Message-ID: <CALvZod7rBAyT58YsVe5Rn5SMjNpdTX8ryqo-WCOVPps_0oDKCQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] f1a7941243: unixbench.score -5.1% regression
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 6:37 PM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi, Shakeel Butt,
>
> please be noted we noticed the regression is still existing after this commit
> merged to mainline, we reported as
> https://lore.kernel.org/all/202301301057.e55dad5b-oliver.sang@intel.com/
>

Let's discuss this on the other email chain.
