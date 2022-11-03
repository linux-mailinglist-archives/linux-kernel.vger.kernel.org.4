Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0431461790D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiKCItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:49:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AB6BAB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:49:12 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o8so684128qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxkWhtwmdAzTWE2PSj2tVH0t5eNv3MSowHRnjz5ll34=;
        b=nV6rbQh1zm8bfQjZG9h5vXfaHWStZ5A1R4OI/46LvkHZvAnluG74cg50Yr0ZIpGmiy
         UlONhLDhtGxphTAtyWnuZVtymDpckE/cO2HoKfNNQQn//gUoSAUD3UtmajbM27Vx6Cnd
         o/OQgq1dQRYtL7uVyd6M1/XFgmb7bkQeiSeipPiFAnBdUnM7AG6iRhVMP+g6u+lHUrvZ
         eqpVcv6DB4imLx8FBT1QpteBvKIeJfb7ty0XCl7lM4GArEMM1z+gtgH01cPVnT5fo34e
         9tredaiFuEhjSsxzGV0QfIvVGu2gnaWfUiBzoeE90aSAx4uBNXw9JIOsStZKa1IIwSkz
         c21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxkWhtwmdAzTWE2PSj2tVH0t5eNv3MSowHRnjz5ll34=;
        b=QKUpKxVch0QPUq/+Us8ftjQ57t+8C37CdaBOmbRMPVY4WLWRaNJ1meKkGQ/oiS3/kJ
         d5sfmk81EQ6czDyplBecAF7m4mPY7RMgUaBGE8eTokNCNq6lJzmKwJuiT0OJIBfCQ1/x
         cuii7+Ri8AKf5yVZSZo7CSYXgqsCOG1fd4skch6pE23hcezN4q+GNsJIamyGDfNgYVfr
         HGHBDxd1nmrU5SlBy+zQniNsUVYFGpgrj7k3WQT38xjtc7YIqv20Hxti3vVZnt2yC32p
         KjITU/8lWOUPlz4c1QlGS+XXSdWH4ZBQXHRB5wm0jZYEr6E+GBVi3wEYnD0nKEFMfcoL
         9TMw==
X-Gm-Message-State: ACrzQf2GrQJlr6cE45YwdxOCmAgLnmeIlEdOJGPnemc7RPJOKIjJr2xj
        EnoX5nsDKNa+l3+gEk4eaGyguZl6DjD1E0xtHsKcg9+pn3tXy2mx
X-Google-Smtp-Source: AMsMyM63t4Cz/ND8vX969NN0IjOpsv0dKbjL2+mkQqPckfoOSZr5YxpRVwdhtxFEt16uIa0qvLI5IXUAkY0tQfF1rqM=
X-Received: by 2002:ad4:5e8b:0:b0:4b9:98bf:92cc with SMTP id
 jl11-20020ad45e8b000000b004b998bf92ccmr25618663qvb.128.1667465351626; Thu, 03
 Nov 2022 01:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667397591.git.tanjubrunostar0@gmail.com>
 <5a0649c6019f1717cb2e2e8fc4e262f3747d73a5.1667397591.git.tanjubrunostar0@gmail.com>
 <bfc8e714fbe80a16428a447768def5764083526d.camel@perches.com>
In-Reply-To: <bfc8e714fbe80a16428a447768def5764083526d.camel@perches.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 3 Nov 2022 09:48:59 +0100
Message-ID: <CAHJEyKV75q90E1OU2YOGK70EBLm8dQe181m_nS_qmPRsPaB8TQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] staging: vt6655: change the function name s_vFillRTSHead
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second commit under this patchset resolves this. please take a
look at it and let me know if I should change anything

On Wed, Nov 2, 2022 at 5:42 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2022-11-02 at 14:08 +0000, Tanjuate Brunostar wrote:
> > Remove the use of Hungarian notation, which is not used in the Linux
> > kernel. Reported by checkpatch
> []
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> []
> > @@ -23,7 +23,7 @@
> >   *      s_uGetTxRsvTime- get frame reserved time
> >   *      s_vFillCTSHead- fulfill CTS ctl header
> >   *      s_vFillFragParameter- Set fragment ctl parameter.
> > - *      s_vFillRTSHead- fulfill RTS ctl header
> > + *      fill_rts_header- fulfill RTS ctl header
> >   *      s_vFillTxKey- fulfill tx encrypt key
> >   *      s_vSWencryption- Software encrypt header
> >   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> > @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
> >  #define DATADUR_A_F1    13
> >
> >  /*---------------------  Static Functions  --------------------------*/
> > -static void s_vFillRTSHead(struct vnt_private *pDevice,
> > -                        unsigned char byPktType,
> > -                        void *pvRTS,
> > -                        unsigned int cbFrameLength,
> > -                        bool bNeedAck,
> > -                        bool bDisCRC,
> > -                        struct ieee80211_hdr *hdr,
> > -                        unsigned short wCurrentRate,
> > -                        unsigned char byFBOption);
> > +static void fill_rts_head(struct vnt_private *pDevice,
> > +                       unsigned char byPktType,
> > +                       void *pvRTS,
> > +                       unsigned int  cbFrameLength,
> > +                       bool bNeedAck,
> > +                       bool bDisCRC,
> > +                       struct ieee80211_hdr *hdr,
> > +                       unsigned short wCurrentRate,
> > +                       unsigned char byFBOption);
>
> Please compile the files modified by your patches _before_ submitting them.
>
> Note the mismatch in your naming for this function prototype and the
> actual function.
>
> fill_rts_head vs fill_rts_header.
>
> I believe this was already pointed out to you by the kernel robot.
