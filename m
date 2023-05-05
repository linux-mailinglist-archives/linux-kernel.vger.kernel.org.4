Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AE6F7CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjEEG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:29:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927E11DB8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:29:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so24070688a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683268193; x=1685860193;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=E7Mod3Itn6r6zM4wj94Xob4QWn8th6C8A8nDh+04rN2ApxpItJz8EOA73UnzHzKt1b
         6z0IJUfp45jEQptMwi7yJe6zrU6Tu/RqZhdJaSKPX6eh+pCwM28o+I9Tvg0u8n0dHFQ3
         8fbtKl5KqD7xAl21yerJGLRcl/ahzswWrw9nsehVuA7Zzn6Tq+u9zIwL2jA+iNN+5sxG
         248EAlk4eKtf52FRwXizNUsVM0ueYoUVhoxQ8hA+NO9AU5UAcxE8CkP6PwnCBZADUYDB
         PdwEis0v/zW4Zki2gGmCnU5EZJpU4rZZR9KKLF0oOZJ6NV57iaJD3TrKWNayhuwDzPcs
         OwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268194; x=1685860194;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=c5ZlwYv7u8AeiYnN2OOJIeMzalXnJDQ46CNZBIziEYP1zuFeu7Eyb74o28qZeT9+nN
         Ve941UrAB2Le2AMPstIB6LPnRCEYOa9TVhK9c5pn1lYTSPZdQHpqWHJsARforbyFXIy0
         Z6R720O1dgy+pPo57hZf8XA8WnZ9RoyTJSH0Me5kjbb3FF7fPS2zmyZq+cZ5JOb3dcj+
         qGPp6ufI9/oztYntcfxL1j4eOPBLUaD5FIYeVPGNsULffo/tajv7DQmPhAp5LdAqw2bf
         RYXxLaDh+iZQBeAzTIED2B2dd1LpJCoQUcwy46+qhMRAaGiVWRAdxYCV7eOj15jKn52f
         d3fA==
X-Gm-Message-State: AC+VfDzB2c9H8LMdv17MLnlV+kPRnOC2EUvXT21a5IamEHYEURK3Jlcq
        ovNV6NY1A9MNWGEUHesGD8iFLiaasrJKL4UA3cI=
X-Google-Smtp-Source: ACHHUZ5nyltEIxpwycE97gqP27e4lhFGtia6k+kG4H2JaLgwrthgxunhLUhTwdcH0cSyai23ap/omilYQIzouWykBz4=
X-Received: by 2002:a17:906:da8c:b0:94a:653b:ba41 with SMTP id
 xh12-20020a170906da8c00b0094a653bba41mr513294ejb.15.1683268193405; Thu, 04
 May 2023 23:29:53 -0700 (PDT)
MIME-Version: 1.0
Sender: peasmuslim1@gmail.com
Received: by 2002:ab4:a4a7:0:b0:211:ef9f:bd5f with HTTP; Thu, 4 May 2023
 23:29:52 -0700 (PDT)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Fri, 5 May 2023 06:29:52 +0000
X-Google-Sender-Auth: pPO_nzpgKxARuTWhOPZ5ChkpLEo
Message-ID: <CALeGLPUuYFixgAOPheL0qDehUpxFmBBmwbTDazzxZF_qQw1dpQ@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share pictures and
more details about me as soon as i get a response from you.

Thanks
Ava
