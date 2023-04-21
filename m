Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FE6EA9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjDUMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDUMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:04:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D13A92
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:04:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b8f64317611so738462276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682078680; x=1684670680;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9Yd8SyiDPHeNlwYxeDiXCkzPOIyE9DURbMjHUJoe+k=;
        b=ZFA6x9s0pMrHsS+mOgrY8pP50x7gU79ihgtizXJCEFX7TeGS7oqaLhjxKwzZAVfCn9
         j9JSsUSRPHowgae9BeYjyncYr6dBg6Ox09rY8sfJDGEBp/peBg69RxSkVwvcmiYR4xNE
         exlddGJNquvfuC+rqWkcfiGGrbMDpR4SyEhU265lEpT7kqPTo3V5xw49C35pLQXXHhdt
         HxR/NYTACh4x1FpBUYvRDoE4W/M+JJ+xVxehd8u+imzHxdxUQCtGwY2Grpa65UBcuiXt
         2PuefwbRJgwoGjOW7/3pmbej+yoQXQmdWQnMd/ovB3hUXeJlFUIZkDoqTCwRP5KEJBSa
         PohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682078680; x=1684670680;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9Yd8SyiDPHeNlwYxeDiXCkzPOIyE9DURbMjHUJoe+k=;
        b=JLhbBGR9RGDqpnKSJ+05X6VwixvSHxZA5DEf4ZdmEU2UZFVL54i8zzgmayD8UkhqQF
         NSsSqNeFglKZuaDPN3J9FDsCvnmWebC/d5qeHYR8JG7w/r5YNWRMZ5tILSPLekPXNBhm
         H+C5FpeJMMgfGycWw97sFEg3GkXrJXsyXXD+FzqZK7KE/yY1lr631iYxcxs5qinBiRdV
         Dni7vxbD+cGx1G/nN8z0aBqRRy1W1qD0gseSN3Kf9M44FOSQ+WrxUUiT2omZx4ynfmxb
         bdg/0siw5i2uUnRYAnreVCEczmtqoKmUKLnJg/iAlYO/kTiIYqrQwNt5LJtT9cXyMSJB
         5Q3w==
X-Gm-Message-State: AAQBX9cr/U7EV92x0/hTx63fM5QtFQvBpSgJnfAmft4D6w/N8SLsDfsT
        U6/q3UVSiNlqIjpg/R1QOPCryWJxstYtdrKmwjg=
X-Google-Smtp-Source: AKy350Z07+kaGg7NHqWCI79r3NQhn2F/22GgGI/0diOp1dJs1T0kmvl1xnGwbuugzs09P4m8JxrRfprDurTZKg+85Ek=
X-Received: by 2002:a05:7508:6046:b0:52:7908:4213 with SMTP id
 r6-20020a057508604600b0005279084213mr162347gbr.12.1682078680364; Fri, 21 Apr
 2023 05:04:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a549:0:b0:3c4:2928:d847 with HTTP; Fri, 21 Apr 2023
 05:04:39 -0700 (PDT)
Reply-To: almondhongu@gmail.com
From:   Hongu Almond <hongualmond5@gmail.com>
Date:   Fri, 21 Apr 2023 05:04:39 -0700
Message-ID: <CACwUDTYN-3OKsgKDJdr=UZsrcN7qaHzy4O15oEe4RdoQQc=3kw@mail.gmail.com>
Subject: Yours Sincerely
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear
How are you doing My names are Hongu Almond a humble citizen of United
States of America and  you haven=E2=80=99t responded to my mail since last =
two
days  please write me back for more details.
Best Regards,
Mr.Hongu Almond
