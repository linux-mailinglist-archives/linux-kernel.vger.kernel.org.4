Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166E5B52E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiILDgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiILDd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:33:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6412A431;
        Sun, 11 Sep 2022 20:31:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id go6so2544543pjb.2;
        Sun, 11 Sep 2022 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=SMR6YWuSQioPH6Os8XTpP5+lKSuupclNHAfA4vuKHOE=;
        b=HhvJFxRzZkYsoH49KqlxQ3mpHQ9BkN+DBm4nu7o6ii38OmWBWhlrxJ/n54et6iYCBs
         ToMX0M9i9R+F1Ne6SeDP4mOhu3sBcrn/3xaPgIwzc1IcWC3vhmujbdTWSMTFH5mVFL9c
         blHz1VZ/WxGNNjIDXCHmj5guTsWiIg5hccHflAvhgxy1whaaDmlxIskr0NHyRhNAVT1t
         v+XTcHrblI2AIT42+qmeL4AaocUyopfShojYVN8Uu412oNVhRjyNpCl6Y6CKVc55P22j
         cugd6fUn/++kCUvNsrVzR2OHkwDmH7Q3TF2Ghxm8s+xdimjzzKDM5FELXwTpydPRdAhv
         vjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=SMR6YWuSQioPH6Os8XTpP5+lKSuupclNHAfA4vuKHOE=;
        b=2FceRjeXV3UuYGDxpUj/0YBTPfkp5QFfvlIKuEmY5VFxsrbboOfbe2HENwrhfxXkxd
         qLtfSlCajq2fVKMwWXmSdoMFbMOSJeyYZZYfcijnhrJ50iFew6qRh0Haw79EwHWPJ3Kd
         kaGMIiLxtXRiAQyF3oQhsK+3lKF3BwBxwyzVnzS9f12kVR8kVg6pfFUUHC0LjQNn3Gnf
         rOuCeryYAbX+WD3OUqUyiI75MWq0Gm0qYg1gnBYKiQQyb5PQ3MkWifwvYkdy2/XUm6Mz
         uoW3+L0juFvrHq82YDfh3MJB4MdWy15A5pG52d9I/8ZfNjwyBR1xiZab+5ajOLI4tJcq
         7ZLQ==
X-Gm-Message-State: ACgBeo2A1uU+/d/Zb8Kqx/yJU0AWK1aPAYkbEw8ITx4BiZLmuMk/QCcZ
        GYdfnJiCctk56P1giMmC7xI=
X-Google-Smtp-Source: AA6agR4PCplLKRsxLzXRwXSlaeySbfdJnAEF9Kl4MwT3HpsKL3FDaX3GamFu3LHN/SYVqwY/MAQxJw==
X-Received: by 2002:a17:902:ce84:b0:176:b0fb:96a7 with SMTP id f4-20020a170902ce8400b00176b0fb96a7mr24708420plg.51.1662953464111;
        Sun, 11 Sep 2022 20:31:04 -0700 (PDT)
Received: from localhost ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b0016ee4b0bd60sm4618699plb.166.2022.09.11.20.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 20:31:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Sep 2022 09:00:55 +0530
Message-Id: <CMU3SV8982P6.Y923I0TZSPYL@skynet-linux>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Cc:     <bjorn.andersson@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss
 documentation to YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
X-Mailer: aerc 0.11.0
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-3-sireeshkodali1@gmail.com>
 <643e8223-f88f-9258-dc36-1732dfa8bb19@linaro.org>
In-Reply-To: <643e8223-f88f-9258-dc36-1732dfa8bb19@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 9, 2022 at 1:27 PM IST, Krzysztof Kozlowski wrote:
> On 08/09/2022 20:49, Sireesh Kodali wrote:
> > This is a direct conversion of the existing txt documentation to YAML.
> > It is in preparation for the addition of pronto-v3 to the docs. This
> > patch doesn't document any of the existing subnodes/properties that are
> > not documented in the existing txt file. That is done in a separate
> > patch.
>
> There is no conversion here... Just adding new bindings.

My mistake, will be fixed in v3

Thanks,
Sireesh
>
> Best regards,
> Krzysztof

