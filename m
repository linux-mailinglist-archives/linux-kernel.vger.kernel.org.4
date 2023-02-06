Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0868BEA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjBFNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:47:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643941EFE4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:47:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so15214050pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjlnPGg9nNmO0H7RRiJn0H4Htz9UMoA/kY/Gl2WERDY=;
        b=OGyunhHACmHeAcJxhcYW/SkGwn52TaLt0onekNL3KnPHHgPLF7jp7hN8IyzigKXfWF
         tdDm1szChdKYwdgKeFEsq0DzIuSIbfDicc72JlA3FwzZoXYQxyZ4cxYyIbGCasfalpSE
         6sOxmPPsEnh0/dco1of6m/+MCF6XeTC0r/cimY5xOXnv4ELCxhCNeQD70j0AEt6Ay5Fs
         UNVnMIyoJ3+DxrcQ4+BZD0V5ysqpjFjDZYZZqVzWlQ4wgg+iJ3dg/jjAjs1G1TiaZu8y
         Esengz2ygq6W+0JqUKklyoY9MF4mkIEja7j0+ETEi9V6r3JUG5lD4jRp/D3BNZMQMCJ/
         Nn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjlnPGg9nNmO0H7RRiJn0H4Htz9UMoA/kY/Gl2WERDY=;
        b=YbsKWyVf09CX8AmvshSCLWym17Kqq1c2Kz+QzRt4YTTVRTtHRw+MpLZ2myzehk7Yzd
         30ifBsPk8hCXeDL6ROq3UkaZFd31fYSdf72b2j7BXf5Wak8BXmj2e09OJCUHIIVfe0ot
         TTwBhYCpy2WWgB7t5svpc9jTO7QgQauxOzSWA3gM9aQl4cDMe2xCTBLyTGWlQ6puSOX4
         QWkB782/w5jqL44jTnWP0iCYr0AS8kmvYDTjWSeaI8fQ0AvxOACRL2+1uHLtkx4gFRx8
         F7zBTSx5Q1roQL4DijEzAJZHJgZEZvZbaVIeu68lwCfogcw75EBuHpzO+cEXbbPeSyCX
         y0gA==
X-Gm-Message-State: AO0yUKXc1P2Q7qhGVZrPg9x6GpQulfUbV9cXQ5GtceGJlrMvVuEre9ex
        JKnRWbFKlxYYGV5zyOthJT6mewAIWnb16X/fW9w=
X-Google-Smtp-Source: AK7set9cofCYWZcne3tXSXZpNcz43daD7YD6AXwjN10aHD6NKGYm3k9dtD5Qk9bksV/9FSyu94fMqr31zsw5P7leIGA=
X-Received: by 2002:a17:902:ea05:b0:193:2bec:a3f2 with SMTP id
 s5-20020a170902ea0500b001932beca3f2mr4247816plg.22.1675691184238; Mon, 06 Feb
 2023 05:46:24 -0800 (PST)
MIME-Version: 1.0
Sender: jackyves397@gmail.com
Received: by 2002:a05:7300:57a5:b0:97:d87e:24cb with HTTP; Mon, 6 Feb 2023
 05:46:23 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Mon, 6 Feb 2023 13:46:23 +0000
X-Google-Sender-Auth: 3IsJXA8cysca43hoZedlsKb8n80
Message-ID: <CAH-+TkWkx-KVxAf7hud7KfcJ0EvTO8hGTWFCepkeHJNuqu+qYA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dia duit, a st=C3=B3r, an bhfuair t=C3=BA mo r=C3=ADomhphost roimhe seo le =
do thoil?
Go raibh maith agat.
