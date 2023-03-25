Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794856C8E77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCYNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCYNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:23:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABC14488
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:23:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so18432661eda.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679750610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFyfxphW4gvszJfcIGrc1v0R57k+ZcqgbtKUyxLAwbU=;
        b=NomjSO7qGeMpJDE1nbxVgLfwRozzp1CpZfxfh/2s6FtAd20KieLu5TtFIsgwd6BsA0
         kJj4+YFjt113qu6vqkgVlYTUDskjGTkBzh9nzbd5Yj6eQFbf8g8dOE44+FLLwJ8FMLzJ
         YnMLksGI7QV5g46ZXT39FdZDAZ9DfZ2lt6RtR31qdEQ1NKSSd58m2d2KRMJaZgaL8/fk
         NJBc+uajxaOD6TJcsDKyoy/DCRJnJa7QCqwdZcdN7B5b99IvRwdoY/5s/hlM6eCyBAbC
         RwQa4+AxMjoOLQGzSsptvy4wlYxmWLfpC5ktJ2V4fh0QbuHZxYuSyelENVoFQD5kthuR
         mc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFyfxphW4gvszJfcIGrc1v0R57k+ZcqgbtKUyxLAwbU=;
        b=m/5MEJB3pm27+XlEYMOSUGI7XakIzByv+q1DLxMcNaV1ilAL0cJwCV59DPG8Fjm+od
         JUc96qLmn+9ZUYpl2eOEH2K/7iqtYSLhMKNkFtzWhNlKBEJNcCGrwI4I5b1YUOGKP/Sr
         wnXMz9hWnzd1I+koKq5J//l2rrXcrfRhdMO2RHhX7iXqDOUWTMX99THdtG+BaWTBg9tV
         RLJTYwoXHuQtm6DVkPbwR7x9WDRjDxkFkvsxqS064DHiJVyhJnpg0QsTo2e5+Q6U5ltb
         bxBI4iwjXxVn5BA/9TY6DBYxATQ9U4L0EudFuWBv8IFZw3BfXQzHtxtLXOYZFu94sNtN
         bOQA==
X-Gm-Message-State: AAQBX9dG2xwd6h/0wInhRcvf91sYoLqQt/2N7Fl6Up+wOcpart7i4We9
        Zb9hTn2ETJ/RtIS9scGMfo9nG6TkFkg1ElHZqLY=
X-Google-Smtp-Source: AKy350ZMHH5sGbdKzT92r0uk3rX6oQerQpXRjZKBGPm6vM90ZYoPTUzVvyQb5zMM5GyPxrAOsXxCPAk/SNPAlAcid9Y=
X-Received: by 2002:a17:906:cf89:b0:932:4577:6705 with SMTP id
 um9-20020a170906cf8900b0093245776705mr3103282ejb.6.1679750610139; Sat, 25 Mar
 2023 06:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <202303241016261854322@zte.com.cn>
In-Reply-To: <202303241016261854322@zte.com.cn>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Mar 2023 14:23:19 +0100
Message-ID: <CAFBinCDMwBvM=KWAMQCVmAOcuPM6K8BwuU=zKOd-7Qv9ob-cNg@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: meson-pwrc: Use dev_err_probe()
To:     ye.xingchen@zte.com.cn
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 3:16=E2=80=AFAM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with dev_err_probe() to simplify the code.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
