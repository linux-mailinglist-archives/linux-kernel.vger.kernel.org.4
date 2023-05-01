Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6E6F31EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEAOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEAOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:19:38 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CACEB3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:19:38 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-55a6efe95c9so7157807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682950777; x=1685542777;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jybv2HPTnK2KcTl9GBXNfqfYghWYeKzO2gMb8Nz658M=;
        b=dt3DUw2RIwe4/+sx4RTcmM+3lYfh2hlVae6+PsRbZDOqU86ffFMfuIT84VMFGMvxK8
         wpF6x52YdHm/OvG4UIWDw469fN5E1BNzOUgqRgTomPFZHIGLmfr2T25elFkKY1xpt4+s
         ivjRhM9pz0Qk6LGsOtslaC/R1J8516V6o3Wg7g3OVGUK3PnT7RG4Tc1dLCW0O/jCvKf5
         RGbt0KE1jcDNON11JuuU6o5Bpj/BnelS/OXjklAPePEbd9VM1tkVnKthCLbjPX0mxD0y
         3F590O0NzhyO7nnep8Q0GbB9OjvtNH26DsGx6mAvPl8U6mwNCHwDcz7/LcZqRwn0Etlb
         shTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950777; x=1685542777;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jybv2HPTnK2KcTl9GBXNfqfYghWYeKzO2gMb8Nz658M=;
        b=QewcNX2aflG6H1PtNbzFZR73/CwrZIgzVqpB+5KPbj5R/3wAU2uN1NzXvvxzknRko8
         CrdfCgwsM+IMiR5SJv2REIA18yeTHeD2k544Qw4akyzWA+FMnPRPzPPE2xRph7IuEgWI
         QyZ6VyfQ6hjRaBSyVq9RssPVZNuiBG3hpgJtALUF9N2RNIplhWH4Jlri8nYJgGaY/SIc
         DUJ6HlAOpCf/loBMB63MGgL7kMek3wzlgDtPATNsVYLjHk+HLi4xzd+14tJ2rXtjkxB0
         gUQqs8TqKlJtxA1m+smqTz35VCcAbAPbjtPsUDMjetdiYlbyewl/EQNEv3s3AxmdeJkX
         +EvA==
X-Gm-Message-State: AC+VfDyKQSEB3dDgpMCchmIWVXg3Wc1AZiCj0QiJY5PQ6E2uMER3ught
        9i+YKkZKxMSPJW2Uu4hrIrh0ubDq+h8MVB1vXEo=
X-Google-Smtp-Source: ACHHUZ6xFtuyJjhMSmSTkf46WK2bxGLlqqedSRWDdNjtxvhRstL0bMNNR2kjjE4KWDy32QDP+1v+0N2qfd6vcqk7OkA=
X-Received: by 2002:a0d:ca50:0:b0:55a:6d87:6431 with SMTP id
 m77-20020a0dca50000000b0055a6d876431mr1770089ywd.26.1682950777040; Mon, 01
 May 2023 07:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4a83:b0:351:be1d:bcd8 with HTTP; Mon, 1 May 2023
 07:19:36 -0700 (PDT)
Reply-To: duongvo587@gmail.com
From:   DUONG VO HOANG <christopherduluh555@gmail.com>
Date:   Mon, 1 May 2023 14:19:36 +0000
Message-ID: <CAMC877U4EKyNyNUm5d05pmhsVKpCKJSPjPDn_KZN1-fVrrpwUg@mail.gmail.com>
Subject: RE:
To:     duongvo587@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INeQ16DXmSDXqNeV16bXlCDXnNeT15HXqCDXkNeZ16rXmiDXoteb16nXmdeVLCDXqteV15PXlA0K
