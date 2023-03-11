Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964D6B5B63
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCKL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCKL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:59:12 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B6618AE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:59:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 132so4489314pgh.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678535950;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iWle2iP7O3ZzMcsGe+0E5W+ig5LC5QHh8IHUW1H3Jc=;
        b=XlAACvVsh8o0oJq5MC2Ui8zZZ9sLrvE9lEyiOnJnU22GkXitISIwo4Rhe2WwY/ztw+
         kermuC0CyNlbXy1ByYHBlOIZVYJzaMl+cgDPXwmcisYLyE4ej/HPD73djVeBRFiMMFWQ
         pvzcetLGvvx28D0NLwdBvqRD5rb58H7lJNIrAp39f6vSNGzbvBi4qPBT6nfrBdYE+TH3
         ULtYK2/bU2Yh6lY+o46pVbphvR0cmSuroHMU82q+mFBywbOELsnsiUPFFmoiGg39oA+0
         GTRL/zkEo2wXZbWOUjTI+4MRAcj/EN7wD7oWCvm62OSVjT2F5Tfx/Gh/eIVSRu/qYK8K
         QpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678535950;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iWle2iP7O3ZzMcsGe+0E5W+ig5LC5QHh8IHUW1H3Jc=;
        b=jO9bnNQgH+d5mna6GLJUgzhWaxNPIGn4uLY/eHLEWtup0YLuqUM/JY/PHddUcXepeV
         O+l1rdm/rkOTQnWSokcpCpeBv31ID+XSQkok2lky8+cZ+TXMzp6CG5emDhoFqbE8AjMJ
         YU7KwNBHl8TBcmQKYfgAEEkEqSw0E0z9TeKkib4Tyq0abKrFNka4sTPmhCkCBB6du37N
         d3xFjE8OgN77WRSVrFih0NaWWHIvyk3FKL8SwDMaGn10zez0ccEIqgORowdBIH+bi/3f
         UPj5u2gODcbisALOFPUnhrJQZeFOzemiV7l+XnPP7K9EudJOdUTSX4KHy2aVa+M4MKNd
         iULg==
X-Gm-Message-State: AO0yUKWifros2cbZ9N5qczkfruQM2+Jb3GHV4DMMMsYPt0VjyyVXiQ3U
        4BEVRk3+CytNui9BAscKfUiTE0vaOQJhqg==
X-Google-Smtp-Source: AK7set/aSX0gDnhBk8gzrT+67aejJXVNC+B/+C1QwsR6NmE9hSRqQUCsm58FQKBalM4nzbI7zbA+9Q==
X-Received: by 2002:a62:8458:0:b0:622:feed:c36d with SMTP id k85-20020a628458000000b00622feedc36dmr241718pfd.31.1678535950266;
        Sat, 11 Mar 2023 03:59:10 -0800 (PST)
Received: from ubuntu ([117.199.152.23])
        by smtp.gmail.com with ESMTPSA id j22-20020a632316000000b00508e7bd761fsm921101pgj.87.2023.03.11.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:59:09 -0800 (PST)
Date:   Sat, 11 Mar 2023 03:59:04 -0800
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     julia.lawall@inria.fr, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
Message-ID: <20230311115904.GA21529@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2303111249470.2802@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi julia,

I forgot to Cc the maintainers of the code of the above patch. I have Cc
in this mail. Do let me know if there is a need of recreating the patch.


