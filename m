Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D067E602
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjA0NCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjA0NCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:02:45 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6E11E9B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:02:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id h5so5851348ybj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DB/VwgUOhDeWeHT3z0pZDhsu54GOVI4oKcLH0pJ6Yjc=;
        b=CYNu0ZSqCgfpiSSSlH4hBB7pwg6nhfPch4mIi/rF+KmWONMg80ZZqfE9lidSr6gtHY
         k1v2TAb9cbq0dSGpl5tDxrwJPvB0Ry7LYZ6ue+En2mSE3WCv71eQov9/NleqU9RTaMw3
         r0ccjtW0sF+Stqx23dcBX+886BAPtTxAP1lbdm5akilsbPLB98/s4elF9wbrL/Dwenfo
         AP4bzPcAKNplihrq+SeKaOGMix13cf3AvlbuRMNA1qEnWBzaRaNEm2mdig64oMu750dU
         Dln09sOzEOa9wOyc4z7jAAjh6bNpHYHLqW7xcJM2etO3wNWGy8ZJ1KhFGZ4xbYWuwxfr
         CWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DB/VwgUOhDeWeHT3z0pZDhsu54GOVI4oKcLH0pJ6Yjc=;
        b=1RIgi6VkvdPTnkntpMe4480JRsqsfxnvjL5Qiu3cGc2YBnzEBGVUZ32k2jTzslUOVP
         2xUX0WybFEj2JQD6kfM0GkvOfSPeTFN3KJjz7OxyM78y80QTfjfEiXrA3pQ2sauuEhRN
         c4PbxwJiMafwmbUkCm+7x8mPw0FsJMlH80Lc7lQlh2EruLKzjPBqqOy5BZ2iI+ANHYk3
         fug+1EiyPGW+IAaJ9kdXzujrAH56IXFpHa+p3ougQq/NhN6UN1qH3B/ZvRqrv9BHAt2a
         76Rj+D0+d0y/3VsDObgLK0vxTBfnDJAlhUUQ/T73Yzx1k4MereFJNCHm7yNoq1CGIWh6
         Wzuw==
X-Gm-Message-State: AO0yUKXI1FQvwoj9pM0burZMSsZqua4mgW5l9sMN2gbblzWRgpAF/Msq
        7CjudCWeyD54j3tlz3JPwIstuvxbMHHJowuTfCSc+Q==
X-Google-Smtp-Source: AK7set/TTpymxO5qx7/c8vpKBYpS1jQegrvVN6lTGO3M26bGQ2hNBb8NJpV0TgjZOgLF2LXIgn/FyvD2IuM7IlpAhug=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr1091077ybd.24.1674824563392; Fri, 27
 Jan 2023 05:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20230120174631.353345-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120174631.353345-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:02:32 +0100
Message-ID: <CACRpkdbvsgZ+bgJyNt1rU0dcWfZj+qFUt1T0+SqCdVbxyFKkzw@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: dt-bindings: qcom: bindings for v6.3
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 6:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.3
>
> for you to fetch changes up to 5b8c304c94d79f44aea8ee273ce70ca380804156:
>
>   dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node names to "-pins$" (2023-01-20 18:43:06 +0100)

Pulled into the pinctrl tree for v6.3!

Thanks!
Linus Walleij
