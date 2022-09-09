Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C138B5B365D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiIILaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIIL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:29:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F722DED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:29:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3487d84e477so15355597b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=7Jo9u7GazJ+NBxWj7pityHgzrKi8PfZunYuslMS0vVc=;
        b=NTTtBLGGL2eNQYdTb+zzpdTYz91YLvxK1ithhO8wg2x7oYFaEm66B2BmGfm/Y8U+43
         in5FuyQwSxzoUECDy0A8wniORIB7Awd3F8wh0EBJ9IUIN+IH9E8pOEPAZ7yb1akOue3R
         UJFHD7AUv1dkh3xKoBLX8TTL5/MkfJlO4Vc2m1FwXPcE1j0uEHWFL/0DSJAVgDde2vzQ
         jgBbWqi+zWSGenExXq6eY++zOJ7QKoHPQg6OrKjnEjW70uT9zuU2R33rPhTKiDUCPTYy
         cbMUg+9qN7U/LaBC0WyxKja1f3v5YqcVpIoPhjM+0RUr3wfnv/1zBom8ERWDJPIq+dwt
         cK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7Jo9u7GazJ+NBxWj7pityHgzrKi8PfZunYuslMS0vVc=;
        b=r1MGYv3fpl2WeCjc31lxw3KFxxaOgo1Gq+lOHX6bZY0rXE8eg5bKBpQNcM+UOqLYyu
         9x/YTGlOvziN4XWo8vccNaaGqn0B614nW1j+zGTUeRsC5TZbaEZeRZYyHGxzkUoaQUUm
         zf40SRyoLkCtjZT+dgy60hIYtqUPa3z0HwpAjIVSxKk5xWSc5YRSLEBoZdGCAmqSUZno
         mmQwiHYrEJ8RblYE8osSAmxd3/mnMTepr42tRGXHEUSJ1GGx7c3zKZBcDX6uw6rjcVQC
         KWuYJZRSmXdjmsi24BBuHiBqAuwG3BWq7jTzBvXAWhBJrBvbZgUE1+NFM0o8O9bPI3OE
         d39A==
X-Gm-Message-State: ACgBeo2r4vj9YG+UJiGptuKKvB8c31uoGCwHLTSubjveN7hYV3xLrBo+
        NDteJRLT/PBRZHuAuH4Wfqqi0loNDS9J78DC154=
X-Google-Smtp-Source: AA6agR7R/MfNjORDcoK0lXV8t9RFQrHqMpfxnNtsIcBc0iADkFWIqulpYuzSrOkBm+WbCLdZT2CBm9jTCmRaPNMnxiU=
X-Received: by 2002:a0d:ee01:0:b0:324:d943:19dc with SMTP id
 x1-20020a0dee01000000b00324d94319dcmr10912160ywe.325.1662722995847; Fri, 09
 Sep 2022 04:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090856.18427-1-namcaov@gmail.com> <YxsUEUqbKRW85Z24@kroah.com>
In-Reply-To: <YxsUEUqbKRW85Z24@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Fri, 9 Sep 2022 13:29:44 +0200
Message-ID: <CA+sZ8B_XzDO8pgFJLMzObBMo6KYHeYsttfYNoSUi+CGf8293xA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: vt6655: use memset to make code clearer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 12:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Why do you have to cast this to (void *)?  That should almost never be
> needed.

Because I want to suppress a compiler warning:
drivers/staging/vt6655/device_main.c:869:9: warning: passing argument
1 of =E2=80=98memset=E2=80=99 discards =E2=80=98volatile=E2=80=99 qualifier=
 from pointer target type
[-Wdiscarded-qualifiers]
  869 |  memset(&rd->rd0, 0, sizeof(rd->rd0));
      |         ^~~~~~~~

Best regards,
Nam
