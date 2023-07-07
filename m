Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0174B0EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGGMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:32:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E620E172B;
        Fri,  7 Jul 2023 05:32:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3143798f542so1833588f8f.2;
        Fri, 07 Jul 2023 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688733119; x=1691325119;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLv/JoDsGX47jcvvoeY07hv9TKzLH0cysc/PiN7oQDA=;
        b=sAkZ72G068A7Z51ExOgSI1f2UF3/WmxZPZ2HfKjcqOTrBhkDvYPkTEh2aeejOPAbc8
         HdukXX/HjN9bOxZ6AoOlwwjFvLQDFGB/6/BxAICRYuz2h/gSDTXibMBxsn68qgPR2Nx0
         R3qW/blSZ7xConHDE6m2cANSFTSUElsVyFghcNrWe7YeUSVAGeeX2ig6a0WTyumoS54e
         PJiFeri5KbZxphHsriiDwuKSPo6IK9nSLfFduY0t8saUyh571y6GrfiskNkD2B4zhrsr
         ZgCrUeorAugMtKbKV0/Qmt1F2DQvuLjmjkt58dnKekWeGupWlXw6fzzPgFq2UQeJG/Ca
         cnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733119; x=1691325119;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLv/JoDsGX47jcvvoeY07hv9TKzLH0cysc/PiN7oQDA=;
        b=OBEJVHZMpWlr1axqgJjdTPdd/8IwrpNfATNMX3+9y4QWqLvuZZi8BTDDX3kTb1izei
         StPrhDvHaSINreSrrBNjQrCa8GGp3cTn5Cr5rdguvzhHl9sLnWBAD7SqWpO6shfUQYcx
         BgrhBHeVr6p4OuQPT3/E6+dNLN8vWWRFDvFNikfgFotHj9yx1yldqDLbzg88Vp5nlF2Q
         IdYx80hmzzkkvbuA2HCeejrxXLeD0ehwhL685N6Dg/Q60eUMo61Hu9zgWUiArtoVRHpi
         tkBWhMbxFmQdjJ7J7bJPxj0+U9ZxXoVN4yGLpXD6+gm5sNFFysm+ofsu+NQir6ePXH/b
         7UNQ==
X-Gm-Message-State: ABy/qLZ3jKXIhlXlqliUkKz20xq2bJLJBRF68iyBbvohoycxgP7wUVCW
        +Qa2a1nFV8H9MctgdsGgyYo=
X-Google-Smtp-Source: APBJJlEaA/PrPpQtB/TTC1JeyhE32ifnh3RqpG+WT4R6LY4iDbxIAKAfJ7QAZydE/TK2RspL6BmJAQ==
X-Received: by 2002:a05:6000:1109:b0:314:3a3d:5d1f with SMTP id z9-20020a056000110900b003143a3d5d1fmr4040575wrw.19.1688733119296;
        Fri, 07 Jul 2023 05:31:59 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id z12-20020a056000110c00b0031423a8f4f7sm4371348wrw.56.2023.07.07.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:31:59 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:31:49 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Message-ID: <20230707123147.GB17845@debian>
References: <20230601160924.GA9194@debian>
 <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <20230629123559.GA12573@debian>
 <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
 <20230630153923.GA18237@debian>
 <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
 <50181937-19ea-ccca-057c-eb6931f4b2da@nvidia.com>
 <20230703142314.GA27131@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703142314.GA27131@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to reproduce it and found the bug that explains the problem
you're experiencing.
I submitted a bugfix here: https://lore.kernel.org/netdev/20230707121650.GA17677@debian/
Thanks!
