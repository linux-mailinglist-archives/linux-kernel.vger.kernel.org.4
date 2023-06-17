Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB6734255
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFQQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:55:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3196198C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:55:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-982a0232bdcso292497366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687020905; x=1689612905;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=B7G7BepedhNo6t13ST6j2exw0x1ZwmPLVEEL3yxeHecRh038gzTrDkWWrtQmqVS3YY
         /TF2soaIOjayutNM5vRnbbrURmOkTvG32YHkiqOWlSlrgOt0PPfJfcsthvrEP0taYCRD
         gQlq1vPdNotdIXCMXJjmnfl2ndziy0omZ3xjLY/A8lmvOJCTX6mNudyTMnmGPXYlsNGa
         SFUlVFLDM9TDGIDCuURZ749AA75BYPM1yqy/zFBZM/bEBkNs/TzoywCUI9GBsl+7knrf
         ALRzVNGxJiZwybeZpbktw/E5jAWOAcdBl/UdW1eAcnu2hyYNRyekxtuBwVr/9vK1lvC8
         gWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687020905; x=1689612905;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=ROtOJj0AeI5J9iaEb8BpOgqaN9SCNuq6oqEWVolmBYRrmItPvlaLiNY6kmKUt2mltg
         NWiPwDt6QTP+gU18zPWj7UWlSOnlVbAe6LtHMByAM2dRBPYtiZOowm5ISY5NsekZE2r8
         4CJ1aR+VZq479Bk9ifpj2AdfY8bBRaku1wBjxwSn1QjBrflIwl+jMZ2LACRqfrC86EJZ
         0MmBO3UCZvu9oFhZ6SxRwQOH0KrBdruXgI9S8bDyjg1yd1apY2pYB6xdYv9hkVwB1PtK
         BpJcjh3Y4UXiieJqB1kWbEozEsh5IBdIRovoyhfSEUH9XsXNWfH7o6iFWIO6rXd+khOl
         2d6A==
X-Gm-Message-State: AC+VfDzTy2MA0OS9Twy+aYdk02qKvJtC3hy52Wp3PHhGs357ldbm/EKP
        8bWK878UVuCyhuxQ+CzSV59S4z9hKPaGVt62Mys=
X-Google-Smtp-Source: ACHHUZ4vEX+inrtqwHd+bRSNE4Vl63pRotTdLXX6y1F+F4HxtrUIYCthBlskJGvNksHnytK6olEOfYgR6VPBeamEGlI=
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id
 xh11-20020a170906da8b00b0098226c56525mr5401200ejb.60.1687020904881; Sat, 17
 Jun 2023 09:55:04 -0700 (PDT)
MIME-Version: 1.0
Sender: princeeminentunuebholo@gmail.com
Received: by 2002:a50:718d:0:b0:21d:e168:6561 with HTTP; Sat, 17 Jun 2023
 09:55:04 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Sat, 17 Jun 2023 09:55:04 -0700
X-Google-Sender-Auth: EL0NkoyJdlUROZ0VFp0rOFL_6dY
Message-ID: <CAK0EZHQuR_Fh7-p5pqVzqbQd=4OLJtJJthAQUxoV08CqbXwgzw@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
