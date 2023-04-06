Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D596D8E01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjDFDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFDeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:34:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732F7AAD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:34:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so146104610ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680752049;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd9oC+qN9vojxTpZDloVHGiCls3SDiZuksEePnvnriY=;
        b=mwwUZVUUVuiprHOjTaypIoPHuXOIzi9AU0bJtbdFPvdDAo7ZrxTjz8eSbtv/lKOygE
         e67aPag1RobFOi1LTAy3+x6PLJeAfBxh6PDAevqSK1JHcKTH1oXnTh3Nrwyc1B00LpF9
         z54Y+bPT0pu9OCxBt6LhoM9c26oxKO8iqKhyKN4HJVest/KfmPZYlBuV5pi00vr3FCij
         jlMqkDi9AWBNuORR7Qgj62Ya3/b0mFQW4FYqrEGLCllOuQDPGCCdBpQ8iD4JqGkyVAKk
         DHVIRRLau0SeT3gteid40i4l6hMvz6FC63CilTd8RuKOQ0o64bMkviOl2QiXD0X3zrrA
         sy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680752049;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd9oC+qN9vojxTpZDloVHGiCls3SDiZuksEePnvnriY=;
        b=KMe6MZfrawF2xTRigzvZN8aDVV9kxIJ5zWo1akCDOTXaYNBXdJzBaSfhikDQ+LXyap
         X46EzTVhNz/d/ULc9gzjZLCLKF6jQkGhkIQ8NkdolVHGIE/fxt/tUatqVPIz7tSu+iC+
         8ARIQRfi6BbXgPyBMyi9Hn2auioEtffd4rgGXi/ZKSI/57zsMzEwT+qXLw3ScSuh3Bc4
         fccVFfEuYJ0jHdQ4sVrjrgZeGMu65e0ye/j7H57FGv0SvTyqGEAtuye/ASQXloqwbbZc
         NpfWyhBu64VJz/hWX22HohKSPKkNKZEIIVZ1RsZxuygDdm54g7bHFm0RwqJluxuwbxrI
         H1Hw==
X-Gm-Message-State: AAQBX9eMKWEcrzI1CWo+zGzbol7DapRH6fZ/Fh99d/0+N2xtAqBApgXe
        iWJgG9Rtvvaio2x0cK0dQ+bqPm4DH8UNENfqAzU=
X-Google-Smtp-Source: AKy350bGCs2NA2eVi6adpMCdimswma0gdUd1x/zSedsoRbjq+nAlN4i1RpfbQTwXq5304aRmN9pfdmP4UukZU9h4ZgY=
X-Received: by 2002:a17:907:318b:b0:946:f965:4d9c with SMTP id
 xe11-20020a170907318b00b00946f9654d9cmr2882829ejb.1.1680752049130; Wed, 05
 Apr 2023 20:34:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:d894:0:b0:1bd:7ecd:c851 with HTTP; Wed, 5 Apr 2023
 20:34:08 -0700 (PDT)
Reply-To: AvaSmith62567@gmail.com
From:   Dr Ava Smith <atminstruction@gmail.com>
Date:   Wed, 5 Apr 2023 20:34:08 -0700
Message-ID: <CAGNbUyGixinGF1YskhnHu7kg5VzxkrQ_0S35VtASMaZ8DmD4Mw@mail.gmail.com>
Subject: From Dr Ava Smith
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
