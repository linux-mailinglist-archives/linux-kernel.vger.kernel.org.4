Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF39974D26B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGJJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGJJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:58:26 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B36610D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:55:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3a0423ea749so3304586b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688982921; x=1691574921;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or9KDjpUn1ZXN6JFqu4Im7a65zY/0cqAMSkz3dts6Ts=;
        b=JOC00CBzzaCg8BMe4Le5yUaQpbJKUB3kn/3tTPLFUIIkbzPU+HhpzAyvB4C5SqGiKI
         pOKYfdmElFmTavX60v9CnrhoEA6/h5yYu15QfXL2zpdk/jXKjd/Qxtb4leNMuC7LUVCJ
         RPOrPKp2rc4kkP8ES/Q/zq/kezMM7bGL7qsEa1D7ogMY879aDlvecgkQmW1uBKuAL4qt
         18T4T1OuI96uM4ijs2LViEQauJ/1iMF5lWOQE8QKwTBr5z4sMFazwEBPNrNLMvChQdqC
         HxY7aFxF/Nt7chX9oYlqShZAVA5DNu0tC05qdxi51gi5PY2dIbjIrnsqVic6/KrKeUMC
         Phbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982921; x=1691574921;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or9KDjpUn1ZXN6JFqu4Im7a65zY/0cqAMSkz3dts6Ts=;
        b=NLlYjOL+cUQ8pTS9+j2BJAcwKs6eEUdNjgP40TNhQlsZoUL6coj7DtYtHl/ni/Q5C9
         fU/OQlnXwArmntUH0U1xwbdj+Rdmb4J8+uYW/dx8Zd1CXyEQCjIPGaqrQvYDtMRA58ZX
         e9uJha0EP3NS39ABxjiOPx9hQc9lhsIs5C408qxilKD5Hz54u0Pa7cjB/bfhOHpAjGnj
         lG2CY/h9qLedjyeTHw2qfM37xHy78Hgfdr/7FPvSP+zMLTRfjMQ41znsXYeI4xXv0KL3
         AIUymG0Bnq/e0vUsq9/uE3+Ir9NyYF2NYvtK4Pp6ZlfA1QwkTCzTyW0cRmQIVr6hOEIq
         1wYQ==
X-Gm-Message-State: ABy/qLZ9ug6G0UGJDaIFGSw+jItMA/FAGzOSbdiDGUB4iO5HRcdqOBOi
        2oUrEdFDtd+/IcDZpLn/qp40WZMU5wGPwtsa/2w=
X-Google-Smtp-Source: APBJJlHrygxfv/hbiJf1s8v8VcOLFLp7CpfwBfOxrSbzSiiPR1LvItCBI+cpUttcm1fP9401mUtgalirpsv5iy920C0=
X-Received: by 2002:a05:6808:151e:b0:3a3:6382:b67d with SMTP id
 u30-20020a056808151e00b003a36382b67dmr14265649oiw.41.1688982920574; Mon, 10
 Jul 2023 02:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9886:b0:116:4bdc:eaff with HTTP; Mon, 10 Jul 2023
 02:55:20 -0700 (PDT)
Reply-To: sar24104@gmail.com
From:   Jacob Kriek <dmonigdept@gmail.com>
Date:   Mon, 10 Jul 2023 02:55:20 -0700
Message-ID: <CAGO6Ue-NqhnCWsgbEcWcsKoanxW-J5qePFQx7d9+SAzSioRqtg@mail.gmail.com>
Subject: Great opportunity awaits you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello, I have an important information that will interest you and
benefit you the most, get back to me if you are interested in the
information. Jacob
