Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F570AD41
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEUJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEUJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:36:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC480D2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 02:36:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2b74d258so17253351fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684661775; x=1687253775;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=J9fCeM50HI6aKasuIiiiBf3sJUClnRowBaahZbOZb2yxWyeV+TeP848caKwyiCxcw0
         TNQywZMRTBBlYF2L2Ow2vLrf/MlQhyhztcDSFnX5RdQdswuZyBesjwgx4FSmwsMAxDuB
         tdPmPvcNmOWxOqRZtgFW8s3DqoWLw3xNNxq7rarqq1Kwzet9NDCuX5rTsGcMbVeuhtc4
         aBYs4KrC+6WRqQ2O7h4hpE+IIPMgXAvzj400NqLjz5z0pGIbz0nyURu/2NFdwYKrIcoi
         +U674wUxpyEvWw5etbYF6B5nTI049vDgv/zwImjqEPMVUX5DKvIh1MPUFDvpJH/gKXNi
         9MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684661775; x=1687253775;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=UUujAKmcmh1KJ4T932ovSb/VkhZrcKtB4z81U9laXWXGMbdT4kbeh6wfxMCFk8p6qI
         99zNWbuG9zTtB+XR0YPO3gIWoPE50b5lFDwDTwV2OiXH1jlQ/VouOs/XIRjmkIfZ9h2h
         kMmBdgTvoXVcSvXevJFbSHMYT4JZ6QgDZG5iYo2ptTch3hqb2uQFqKhOLx2jHdUh/qbs
         P7U6vrC8QxOTpCSMKf7VDNYi7aPstp9hkFgsG/OOVW0c8oQTalj21RG+oVk7498QHAAp
         /wDheldBQeUa8wQ/ST+ohUc2VMH0nNsVkiFqb8B3AcSXaamVkf95fkHKrbpC94PBasOQ
         JGIg==
X-Gm-Message-State: AC+VfDzlmBPYKHrGC6hEAUQ3F1IyGFTlOyZiL/6t6N7KaW3wCXudR1B+
        jx75NrTenXHALOrrvIG3f3hKo+Lm6uE6CrpiXDY=
X-Google-Smtp-Source: ACHHUZ7vkIHaMuXduxVNHyZfndou0BiGfzrY2X+0hMOHbxdAyTy7W5l5B/6zvlWq/LvdJy45CmvcsGaEr3kKk1yGrCs=
X-Received: by 2002:a2e:919a:0:b0:2ad:988e:7f8e with SMTP id
 f26-20020a2e919a000000b002ad988e7f8emr3206317ljg.51.1684661774640; Sun, 21
 May 2023 02:36:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:240b:0:b0:2a8:d38d:f29b with HTTP; Sun, 21 May 2023
 02:36:14 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly90@gmail.com>
Date:   Sun, 21 May 2023 02:36:14 -0700
Message-ID: <CAMPxFe=KMVBx4Q3zMsR6aOAiAxpsGtO=amW+8dQwT88qkAX9pg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
