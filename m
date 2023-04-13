Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD46E0626
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDMEvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDMEvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:51:23 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC24EFD;
        Wed, 12 Apr 2023 21:51:22 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id o2so9534543uao.11;
        Wed, 12 Apr 2023 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681361481; x=1683953481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGpfccEFlesihlPqD7G4pgrCSblH7OAQk2NFUzrS9uk=;
        b=GF/Wy3m+NhO5Zn+rcy1va1rPn6eDR1FoxK7eLKhYmDSidCitNMI+GiFUWnYq9YM1a9
         68egP8hz6WxR1K0CZx+UWHGMfHdoF9ZHaAF8YMobSNq4jctKr+78q0A03EQjN4TFXUqG
         l0TpSDcmZGzCS7+tBmg3LeSK8uC98NQ8KLW1qC9/QRqJbJxjLBmzyf1QbqzQDAEUG4Be
         lJqSkNxCUa3rQD7ufDJN65vCfkCyx8CsjCps3boEKApBUnN8AUXnwgmj+VMNQqrWpAJJ
         NFoL/Bv8jeWdXSqTJLZqHiDWcC0VbaxkABkgQZQli5XQ87mf8KjwqluHwjnXF2JGbi41
         7vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681361481; x=1683953481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGpfccEFlesihlPqD7G4pgrCSblH7OAQk2NFUzrS9uk=;
        b=hypPHqay6gAowoVY+P70gfXMu4qaw5qR53I5CpsO3yvAC5E7Q68F6gJKpMkChzUyQc
         YLitpaOv1IF4bst217sKjnKUDzZ3tWgwlgILksa88uJZGlthqjIFEPET6uxbK+H8pM4X
         HOjRLwoHWlC770Pmz4wDHvJRNSMrl2a3BTuurQPRy0+xOJTAr1jX/H50NUDdVOnVYLCq
         ajjq97oXuN1ghLbZN1jcMPIfkdAOGe0N2kgkkz31fo9MUE6uS/ulHU9MiVqYALnSCqyB
         gUL8xNxIb/SfPn63hGzSJSKTXassiD3tcQhC4Jh3RAXbnkqDdTq9NQSmdsmf57Crow5p
         62zA==
X-Gm-Message-State: AAQBX9fBHw2VCc1qAkxXZImMbW4FlL7aEpc4FcXWc25EpF2TkQeJIjoc
        tbmejwKitMGWpt435JFU3FmDEwaEhej0zvn6O4c=
X-Google-Smtp-Source: AKy350Zb2Jyb3W8YK59sNQdQfbMexJEutb2y35WUse23JPiAlEvVxLaPBZCtvPzaPZgarzNRlPny86/AlBJFTYQZwJI=
X-Received: by 2002:a1f:2004:0:b0:40e:fee9:667a with SMTP id
 g4-20020a1f2004000000b0040efee9667amr271520vkg.3.1681361481221; Wed, 12 Apr
 2023 21:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230320095620.7480-1-di.shen@unisoc.com> <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com> <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
In-Reply-To: <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
From:   Di Shen <cindygm567@gmail.com>
Date:   Thu, 13 Apr 2023 12:51:10 +0800
Message-ID: <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Di Shen <di.shen@unisoc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Daniel. Any comments would be appreciated!

Best regards,
Di


On Tue, Apr 11, 2023 at 3:51=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/04/2023 04:09, Di Shen wrote:
> > Hi Lukasz,
> > Could you please apply this patch if there's no more comment? Thank you=
.
>
> Hi,
>
> I take care of applying the patches. Give me some time to read the change=
s.
>
> Thanks
>    -- Daniel
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
