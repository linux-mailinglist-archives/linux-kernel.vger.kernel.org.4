Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069863B0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiK1SRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiK1SRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:17:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7F24975;
        Mon, 28 Nov 2022 10:01:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o12so2441520pjo.4;
        Mon, 28 Nov 2022 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TV3K+9XJQ4JSRthyl6WsVQpBMzAGFy6Ywhq9PNGcdkU=;
        b=i/LLRGK9VbEmnLFhMuRm9KRExdxXbOdHIs7XbWCWZgWH9PvdXhNk0UEYPka0++rbcl
         5991qwBuQmH3tOEB2TvMPj3Bygfv8hjBwhgBiC2wNrQ6TiLBxXdc/MCX+AiwEeRtuxS7
         5SwOxsUrjdkGwsv/B5mk0kNtSdPNikf6phirk8VFFGpf20aFXVF2uxr40DcJdzFFAnrF
         pd6D9gFKsg08aGzo2GEEVBw9MIn+CgtsP+KJNpQ+0oYsJjrrlS4y8iwh+gd5W4Ocs0Wd
         hHa+7Sg1au6oMwY96vqLWgjN/YmipqO4u9uK9WJqbgXACplN+xuX8n1hB0kqb04c1O2T
         z4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV3K+9XJQ4JSRthyl6WsVQpBMzAGFy6Ywhq9PNGcdkU=;
        b=3CUIOPjrF0dacBMIaAW8bHUGo8JcHv0vaLiM2i4vMKIA3W5RGUmm/aN7kN/UzxY61i
         /U6R53CwseYi8dud2VBMZjQPqirOw0SF8koDRcvt3vhWqeGAN2kVINqg5YebHnIiwXzU
         6p0rUQ3NonaoEUZft8VB/wjw+qvW8PGZnW0vZEKBsAMr3fnpiEeTb0ewkWABcQ+qq5Yg
         RKqX932wO3w9401VNlClBN3CNS6RYnW+01IRlZE/wmSmMIjFNKASGF2d0d9Vb0Ag9jBb
         RNVNMeIVrCUiRx7J9YPPsXTk4zi6l2SZcNUlrzOgPw74FuJrRZcIL59xq4YsuB1MU5ii
         ZxWQ==
X-Gm-Message-State: ANoB5pnAfQm8liGmsiXbLKHLe5tyji6S7fcPY1Bv2deA4kHLuOTlNsOH
        FGRr3aGXeJyCuvcJm7524CBy2DuUv2Q=
X-Google-Smtp-Source: AA0mqf7Z6z2m5aAhVT/YuvYZJWL8ygkLXleFSaxEQCcgEu+VO6TvzUIj1wcRzeb+gffR/0gAOZU/4Q==
X-Received: by 2002:a17:90a:2f05:b0:219:3f4c:3b37 with SMTP id s5-20020a17090a2f0500b002193f4c3b37mr4592340pjd.50.1669658466736;
        Mon, 28 Nov 2022 10:01:06 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fd7c:c075:f9ff:46c4])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79581000000b005755ff41c35sm639917pfj.161.2022.11.28.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:01:06 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:01:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] Input: elantech - Remove redundant field
 elantech_data::y_max
Message-ID: <Y4T3X+qWtWdZF1QS@google.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-2-nyanpasu256@gmail.com>
 <87sfjqzh3f.fsf@baylibre.com>
 <a40d32e5-f310-b485-d789-1d99a547e3e8@gmail.com>
 <874jujtdgg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jujtdgg.fsf@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:29:03PM +0100, Mattijs Korpershoek wrote:
> Hi Eirin,
> 
> On Mon, Nov 28, 2022 at 01:18, Eirin Nya <nyanpasu256@gmail.com> wrote:
> 
> > Hi,
> >
> > Is there any progress on incorporating this patch into mainline Linux?
> 
> Dmitry (in To: now) is a very busy maintainer. It's possible that he
> missed this series.
> 
> If in a week you haven't heard back from him, I suggest you do a RESEND
> as documented in [1]
> 
> Don't get discouraged, and thank you for your patience!

Hi, yeah, sorry, I have most patches either sent to me or I am CCed on
them so I rarely look into the mailing list itself. Please just copy me
next time you send out a patch.

Thanks.

-- 
Dmitry
