Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED79D6E97BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjDTOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjDTOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:54:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B110C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:54:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z6so7029018ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682002497; x=1684594497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iyJ10kPE9vpffTNqiExQeocolbd4Dj0tHjXd0WvM0M=;
        b=o/R/AqmKaGn1+aWhfg0fOcli6osxrzcULaAhnmjX6qtuibW3tE/YESm/bEh5mUmkXE
         8OlfRyelDy6IOPtmoqsqbyJxEwAB4fCQ1C+NO3AVIOtV6EvNyIEwvkOVTze6Xp8D7lEE
         TZ9DlX+w1S1zspGmlHf54ECkAkYagPRffvBM2dCbONSKXCV934R1E/O9N6GrSWTcMmzC
         Hxu7M8ixZ0gqZJX/iajkcZV76vXEkl5M1IR05dwXQzahKDWJ9z3rDj2KSffKmtKI7EGv
         ShLhu1rPaBTR265dDCCSRk2b6R74iMrqri0+zgwDEYurgM30OzU78a3o7/0t6UwmjOF3
         h5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002497; x=1684594497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iyJ10kPE9vpffTNqiExQeocolbd4Dj0tHjXd0WvM0M=;
        b=bbCG2qmQrP0EiCZJ5Q0oCKIZgl+1YRdUrFKjRJOjYxZ1dbbgYaEVmu5FWMPloq2WSB
         AE0fLlEFGUz3pDgTzaUI5QdRe8W4Gyks+/l7sKrbc7WTpZ5wn4NL/l27uY+DEKuXb4zX
         LQEuxCHM6FFstUsCUjj+2Rq4MiLMEPzW0ZOSCUmD/lxi2bp25oShKrxKPBFkxUNJDBO5
         co1sHPCeSPcBEWwZqNq2CMt6USRLS9OYJhGWbsaiLSHAnt9pB2Uw3EjubjNYGNoEmq93
         Jbpqq+5rcIK+hEDrdp+Xj2orLVrqVBaZ5NGQq3H9wfHFCkdkmua5eRwpi7cawzWW5Woq
         N62A==
X-Gm-Message-State: AAQBX9eQgz7kMmdsU/Y1VtdyaoCkwD5o30kq1VYJv9yk6zeFqFBSLoEI
        8l92X19SbbF/wONr4JZczLaDgJAefWvzeSho
X-Google-Smtp-Source: AKy350YSSEwYhbSVNgEMusBy3yq/4BeX0EeXh1WWqkA3sCdhLdxw+gBxjoNnG2H+9q9fo0ccJBovKA==
X-Received: by 2002:a17:907:c08d:b0:94e:4c8f:759 with SMTP id st13-20020a170907c08d00b0094e4c8f0759mr2295871ejc.38.1682002497168;
        Thu, 20 Apr 2023 07:54:57 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090686d300b0094f109a5b3asm812784ejy.135.2023.04.20.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:54:56 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     broonie@kernel.org
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
        support.opensource@diasemi.com
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring constraints
Date:   Thu, 20 Apr 2023 16:54:50 +0200
Message-Id: <20230420145450.1033819-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <90c4c45b-daae-4f38-a60c-6bb8d33c025d@sirena.org.uk>
References: <90c4c45b-daae-4f38-a60c-6bb8d33c025d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 at 16:37, Mark Brown <broonie@kernel.org> wrote:
> Right, but in any case where the monitoring is enabled then these
> properties would also be needed so there's no point in separately
> configuring it. 
> The driver can supply flags to tell the core to do things like it
> already does for a whole range of other things, there's no need to
> force things to be configured per system in order to factor things
> out. It's just a question of where the core gets information from.

Ah, got it. Thanks for clarification.
