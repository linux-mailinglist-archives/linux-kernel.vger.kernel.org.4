Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8764D996
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLOKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:32:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D792CC8A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:32:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz12so28554425ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X6BiBdusitFTAeaD0Y9ZQz2mX9NoVrMcMfeWBrudFNE=;
        b=gIvejujABPGF56JQ0lBX3NIdnpXYjc/UJ2S0VSyEr/MJ58DncxPCONoLfSOvbzEu16
         vVJKHaQv0ZNDSR9QCUsKKXLL73mFygCDiNsWcn6JF48B/YY5l1O5EB/okqAImmkE5TdA
         OhJgnVFqLTWasyJyGUzcBJvx4Rm7nJjK81wkLdWlTtIoEDCpy5MVJs4xPZXwbQFDRXOs
         dzpG+5bUpc54uk9aoMdzGmmCjNKwj0qXYR15K1+6yxz+aglSvWHll6ngbCcdOMSA5JA+
         AdheNeL+P5egCYljbP86i6iJIos2LOXXGGldHeRRetgWT8vm56g4nIGOSK1qACvcyEbm
         TrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6BiBdusitFTAeaD0Y9ZQz2mX9NoVrMcMfeWBrudFNE=;
        b=Q17tu85kOt3pOPzM4qw/lCcNd8uq/8eLR517juy0aioY50kGlqMsN/hsiBPUKLPPK4
         6W5gEpQQVMi6m+OwhnuAA9iNX2jlaqN0JOqEtpIvRfr/BvNlf4/8SnYIBxOQJOzs0931
         /RViSRS3+nqFsht761odLTzEbQvv9+ZaepB3q0vIse9YodwL1KqVY7FXBl77GyFUtHdO
         Do8p35FqJVh/NQ/keht6ubQGZNCEoKDBjG5yGk2HclGqFRFlm5MfqxjudSd/fxIYu2H7
         FBNGgvaim//D5PXSrX73viXmi37yCUDEhbMv3q3Jvqkn6PeIZo90/6T3Xcnibdmg/xPW
         YlhA==
X-Gm-Message-State: ANoB5pmVeHwKpveUkqaNaff1gPYjPy8Fletn5WExQ/G1iIx5MwXXtH75
        FMhxJOcC3mdpuXCojoaF5IpEt0TibuNpJsoqQTw=
X-Google-Smtp-Source: AA0mqf4js/+PJdvDzTLS9bkLsnvJmW5cUNZVbmWwWL5wPKFzwTH5ViM/Gpo/8cWvaL8gWLatCom6O6k4YukWYJFyy0M=
X-Received: by 2002:a17:906:6a1d:b0:7c0:b569:8efd with SMTP id
 qw29-20020a1709066a1d00b007c0b5698efdmr29057224ejc.652.1671100329915; Thu, 15
 Dec 2022 02:32:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c641:b0:27:afc4:1123 with HTTP; Thu, 15 Dec 2022
 02:32:09 -0800 (PST)
Reply-To: attorneyjoel4ever.tg@gmail.com
From:   Felix Joel <assanacheikh@gmail.com>
Date:   Thu, 15 Dec 2022 10:32:09 +0000
Message-ID: <CAHZ_=5dG5zM8p3-_bz4HVTBQqLcXBB-w9diR5a+wK+YnzZMUKA@mail.gmail.com>
Subject: =?UTF-8?B?S8O2c3rDtm7Dtm0s?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
J=C3=B3 reggelt k=C3=ADv=C3=A1nok
Felix Joel =C3=BCgyv=C3=A9d vagyok. Felvettem =C3=96nnel a kapcsolatot ezze=
l az
alappal kapcsolatban 8,5 milli=C3=B3 doll=C3=A1rral, amelyet egy itt l=C3=
=A9v=C5=91
bankban let=C3=A9tbe helyezett n=C3=A9hai =C3=BCgyfelem, aki az =C3=96nnel =
azonos nevet
viseli. tov=C3=A1bbi r=C3=A9szletek=C3=A9rt v=C3=A1laszoljon,
K=C3=B6sz=C3=B6n=C3=B6m,
Felix Joel =C3=BCgyv=C3=A9d
