Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C776B21C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCIKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjCIKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:45:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561CCF0C5;
        Thu,  9 Mar 2023 02:44:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id bd34so1190900pfb.3;
        Thu, 09 Mar 2023 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678358694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bZRnwm6vJUX6c9PD0t0ElYNdThObW9NeTmHVWm+hKM=;
        b=LhaQqrvDxgLejCELCVlgsYceVzoVl+hLRG5f6Jn4jqsO46hvqxYgNuYpSzRfMAGlIT
         0QkwJU+Sdy1yzDW2cBlbI0i0/JzlTmbSsepAIWoizSylZX264Z81TbuRc7PftWFIMWnA
         ETRZ75BONunjI0XFzFvt6RHgcweNHrdMUuctl09l5meaPFHjJGgfxw5H99i6LaG43pLe
         EAyCd2OVIvQq1TvjRx2K5xq3nVd55uzs1ZFFWI10HBvbQHXJ61i9CzoRmqjqb60e/pIu
         jil+DESNDlJUdLe7/0ozHjwsF1fy+y55LtAJrEHiuAObzAidtTIUiUsdc8EaGIOacLU4
         UTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bZRnwm6vJUX6c9PD0t0ElYNdThObW9NeTmHVWm+hKM=;
        b=DDwIymnW6DDn7YAFoo/I9CbLTHl+O2AaXxcbXaR7IzSnmUg0unTMxkV2QLPqg1bUY/
         lcx3G+uisSkOfVa3wgyjkJPlcXVniPHwEu696TXq7VhiKgnbRC88IGD5VqEhO6e4eXE/
         /QkwK3+lumXSKrfqDib++BxOje6Yin+mb9iDviZDcBiW7E48O1M8Sy82p8oeS+k/JyiQ
         d2qkTCdv0gb9iaHmaGrMzW0p3MV5hIDHY+9xddDpx8AcFc+NoYgNOmj2GAg5Du63Iebq
         YVaONwjC7Wpko1C/xDZS6zt3c90oLhL0LoaWnLTqbLeH8DCHjNlrNV5wLFFQFvXcvfzn
         t0Sg==
X-Gm-Message-State: AO0yUKWb8OymJuCMSCmQDXzfdcIJlVFo0Gus/a60lxxh4Sk7v8zMIPIc
        yo5M1y16vZ6/5lBU/78BDERPT6ZUBRfh1F18q4w=
X-Google-Smtp-Source: AK7set8zqKyx3NtXT7Zlu8YshN1KXUzw3AGFAfe4sTl1fQmZVsdRUTXVG7zNYB5yySxeURoVUz82loo3xwJMo9qMR3g=
X-Received: by 2002:a63:f350:0:b0:503:72c5:dd77 with SMTP id
 t16-20020a63f350000000b0050372c5dd77mr7739927pgj.6.1678358694349; Thu, 09 Mar
 2023 02:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Mar 2023 07:44:42 -0300
Message-ID: <CAOMZO5DE_Gk7K02pWgtmUtFd4d4dbzTg4H-ga5UqnkC5AK2y2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx: Remove get_trip_temp ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 6:28=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> The i.MX thermal sensor uses the generic trip points. The thermal
> framework can return the critical temperature directly.
>
> Remove the pointless get_trip_temp ops.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
