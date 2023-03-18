Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93FC6BFC81
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCRTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:48:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210122DEB;
        Sat, 18 Mar 2023 12:48:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cy23so32585417edb.12;
        Sat, 18 Mar 2023 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679168933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiugbEJX8e4tBR8v5WrizkFrQvCAxHo92Z8AgfyiYuU=;
        b=TAdAXNRbn7vxfUflIzjabTSIrtlEfFeb7PkwwR+gZ+PRgiUx/D4T2GPf9ziaXyGqHY
         ugzsDlfiFNHi3rYsSibOyy3I7zrFRDsbxxCQGWKIptxXkoUWOfBsYyRbhueYNR6QY1vb
         RYTtBKxRZI2eb46kc69DXbblmouCAMUvabgy6FdvBRIuyCh2ZpkZV3jbiUoiVF9TqeQK
         SdzDcRAXL6djJA2bGDyuOMtMDV1S4ZOcThDr+2XiTpGCJKUU0seWWuswifS0Box+FKyi
         P9cJ+y1gqy1FgGKC3XeasyVWlvvOK9s5Zi6OVFvYA6+xG7h1zmfgKu3I/ZE+scdBuABQ
         H7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679168933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiugbEJX8e4tBR8v5WrizkFrQvCAxHo92Z8AgfyiYuU=;
        b=GibVShz+e65NWROMRA6eu8O9RL2s2OdGXll6q8osnGVNFRkWaeAJ+8woOQgLFj+qzW
         QzSX44RcJitE4o02Wtn9jMEwRmXkxtu2oWzYLTr2uV/6oXHLKFk5jvAf3T+jVMCc1+T6
         SjmAXvT08RM97qFak9gK8LtckFDid5w+S6xLWYzZtHUJGapSuO8ZMJaubu/ELuwSRBKe
         jH+KNbnioWLMvV/RKN57fxE58RZEiDM3q6RYr61m1eoaoctEpfybFSnJ2UJWllr4LnCD
         3kwIW+ukdBRVNkNyRYFpfHMKOwH+2q8AwiLIq0WwVPk4TpNR/GruKPMkeE1G4XmR5rep
         MlwA==
X-Gm-Message-State: AO0yUKXtDoF2tVBYLAdKCswZFf1zPndyfvwccS96ffCrpgijV4meOo1r
        FrrLoMIIkxgF0V29HtQgdCeEDhg7BfRNLCaTEOk=
X-Google-Smtp-Source: AK7set+2wo8PTsdUJYcZlYuKUue/uK9itVzfKPEX5A+p+E1AWA3LaKu3QuV9nEvRcwUlT5FIDwTsb/G8zm9tdenhU8M=
X-Received: by 2002:a17:906:bc9a:b0:924:efbb:8a8b with SMTP id
 lv26-20020a170906bc9a00b00924efbb8a8bmr1713848ejb.6.1679168932708; Sat, 18
 Mar 2023 12:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230318144412.75046-1-frank.li@vivo.com> <20230318144412.75046-3-frank.li@vivo.com>
In-Reply-To: <20230318144412.75046-3-frank.li@vivo.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 18 Mar 2023 20:48:41 +0100
Message-ID: <CAFBinCBFXok9Of0dvZCZrw--LdFOihdLOEWPSF9UA5Nuc5eqEg@mail.gmail.com>
Subject: Re: [PATCH 3/9] thermal/drivers/amlogic: remove redundant msg in amlogic_thermal_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 3:45=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrot=
e:
>
> The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
> print error information.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
Assuming this is applied after/together with the first patch from this seri=
es:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
