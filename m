Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F3654617
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVSpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:45:37 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1721DF11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:45:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 83so2132700yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZO0VTSbbcbYZiJPaOMLh4dyINA59L0dviM5rTB/N30=;
        b=V67A64iJJgBrjZ+aTi5eGT/XHfSFML26yXbyNNSLyh+ceMbDuFmXnYwdVUW9FtnmxF
         vTtFRSEFwdOnXCyTK3uPVq8e8OkfCGR3Cat0uwEBT3MxekGHPhpMW1nzWrtrgxusZ6dd
         zdeQqgMh2tNkQrvT6no9zdRtTiGpHLD8vpQVsQE5O90Ek6nfPLFNbngFpYmpSZU1e66e
         1ja3momlTcJOdbS6nKd9VDEYBjOsdYvOg/gZ4Rp9d7TJblifEoC+BmBpcZf1pkfO281y
         FRndApx4C9NzocSWmgKbX+TJ+YMZzh3Hy4IjVJWDlZY6PSPv/bcnK+yHENgemf63Dloe
         sNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZO0VTSbbcbYZiJPaOMLh4dyINA59L0dviM5rTB/N30=;
        b=6M2Dz+cg4RlaYhkj42NrTddHrRSihy75I8buqjt75rR5vegcY9FZMsQKPexRnsIqbZ
         yAkpo6fy+DagF1B9sbgs7t7O4Mmg5AZ2FGY9eUkVI9S64Zwqj3L85JHuTHkX9lKmvQXC
         gpY6kDceKGzcvdCvlncVy6XmLwiU6/9CfesTIA/cV3CLj/kxxoUl6DWZ0BqeQZ7Ck2TF
         O+NrkDdGlbRJNcorCMndKBv0AHJq60kKAgfpDQAWb66VHdqB6f8pDeRzFyl2YBfoy+1G
         MhRsw2cpsLDRIAndXuulrHBvXLoFv+8xEqw1Y6nWTNSNycxe18Tb5cRL0lxcbdcYRuf9
         S2mA==
X-Gm-Message-State: AFqh2kpatvGHbe4ab1kGX/fmBlzvm+8X+relxLsFjQC3lcB0amOTaLK+
        LOVmVcsDV8zDIKTMKjp4Gqolc4HBgWJh5dF8Vuw=
X-Google-Smtp-Source: AMrXdXsJpSpfSesp8O9SL82szen1btsnsDyArf2ahU4GOxJyR1kdwbLOz8Cmgls44s4e+R7IZUUPxBJ2U4N3K6krrwo=
X-Received: by 2002:a25:9744:0:b0:71f:d74e:f3f with SMTP id
 h4-20020a259744000000b0071fd74e0f3fmr801891ybo.75.1671734735664; Thu, 22 Dec
 2022 10:45:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:c290:b0:3b5:5241:cf84 with HTTP; Thu, 22 Dec 2022
 10:45:32 -0800 (PST)
Reply-To: rebecca9407128@gmail.com
In-Reply-To: <CA+FCbF2eOmCu_McyuSF0d-Hk6X4kHzN134d3i9jeqk+Dd8RHOw@mail.gmail.com>
References: <CA+FCbF18KVRd6jToXuWoQGNBVQPx0fUq+4SbUoL=JWuwdTOPnQ@mail.gmail.com>
 <CA+FCbF1SVQHhVg0MNrqAMiKe0T2re3uxOfzo6UDF0M_HJF9qHQ@mail.gmail.com>
 <CA+FCbF36YsDma5V2tYf2p9AjMFNnUNe6TjBukNR=pfp7eSgsMg@mail.gmail.com>
 <CA+FCbF2adWnLSJYXpx71TicVjHbXxP_kP0znyK4uJ=Kz7_J39A@mail.gmail.com> <CA+FCbF2eOmCu_McyuSF0d-Hk6X4kHzN134d3i9jeqk+Dd8RHOw@mail.gmail.com>
From:   Rebecca Johnson <sikiralassan1@gmail.com>
Date:   Thu, 22 Dec 2022 10:45:32 -0800
Message-ID: <CA+FCbF1OOJ-UZwyd32ciRLmtjwWjjWUAhKXBf2dCmxpq352v+A@mail.gmail.com>
Subject: Re:
To:     sikiralassan1@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
My name is Rebecca Johnson from Canada I want to open Charity
Foundation and Company in your country on your behalf
is this okay
