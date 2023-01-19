Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38C1674215
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjASTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjASTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:05:17 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD9966D9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:04:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w2so2216502pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=hEi/swBl1Fh3ND7edZ4bfH7ioIGNyfFDq9Zch1F2tgPvtnB6NqNSfAY2HOH/tjhxGF
         +oK4kanqIJcG0AYDANkrwJ9aUj79XsF4qvOJPWumOWKMIM68af+cxpMS9Hy/BNjI4Lox
         Jbv8XxsoiP55z0m8StJGkbYxKCIPxi5ATiqg4BbmM//zSxcv4/4Bs4mOm8bO4Lc1iYtt
         0RwK1eLSRqG173GhtF3eEXTUpHGSEhdYSKEPWUtPKZpA3VTSBP3p6mFl49+bW/oiRc2Y
         cwEC1RTBNPOgtzipXgHstePEvT4+W/tDaDfgCZqav8PRmk97pgVs6NLxoqYchp0Yw0fy
         zZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=Mg3Oar34YWDhCoGYBiLXzLlT43AbDLn8nG5uyAcFVHdWeY7sxGAKjdsm7reEl/amCR
         oVq9bfhAq6ULQx1zlW8HpY2dgpkeCiV6RCvfPBdG0WyhirUJ8bgYSfFM04TVLwV5o6Lg
         z85zZNLssKuGN4olePgx3pL8JvDta31W2xEw/InNkkj9aQiMof+CHLmxWYOJOHxR6HZB
         vQw7wTPkdt6E1vF4VAz86sn9JYdIxq1cjSfPcssPdY56m8hsIG7KbdGM0irBkT3FeulC
         G28WJdNVg31grqv2lNkDoIMqWAhdN3GI6kg8RrDrs5RhxB/KrCCtUC10D6HS/j+68Mw1
         UsOg==
X-Gm-Message-State: AFqh2kpu7NRoZzLoVYYv71dzOJ+N+M7TE0CheKpGocu+8EAJU9z+oTw3
        9ZCBBlONSD4V0LT5tmLDTzOYGcGLuaaQucg3FFU=
X-Google-Smtp-Source: AMrXdXvdl8DsAmzXsKUW7UqfWXnlTDDEEJ6zgTl74tgHsmC8OmXNL2tDgFRQJOS982pLTZJ54jdyTsSs+m/THYs/eUE=
X-Received: by 2002:a63:2153:0:b0:479:45df:425e with SMTP id
 s19-20020a632153000000b0047945df425emr1006483pgm.116.1674155028337; Thu, 19
 Jan 2023 11:03:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a06:915:b0:5b0:e592:ea6e with HTTP; Thu, 19 Jan 2023
 11:03:47 -0800 (PST)
Reply-To: zjianxin700@gmail.com
From:   Zong Jianxin <mondayaneji@gmail.com>
Date:   Thu, 19 Jan 2023 11:03:47 -0800
Message-ID: <CAKxzvUxHAHt+LPbjA99iHjyeL_X8cm3q9P7ujhoypmvJr5RQaQ@mail.gmail.com>
Subject: Hello!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive my previous email? I have a Profitable deal for you.

Thanks
Zong Jianxin
