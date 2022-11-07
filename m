Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C134B61FEA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiKGT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGT3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:29:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199C6273;
        Mon,  7 Nov 2022 11:29:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so15655098pji.1;
        Mon, 07 Nov 2022 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROsSP2zJLMpqkNAkCkejAhjTOebhsc8Ura1yv3/lEHk=;
        b=P4B9TBMmaUKzX1GYrwQo7DZAJge385WbTniJ5hPd5TGarQl25gy+JuH6EEPIl+QSeq
         WeNlcpvUE3IXQ/vtcSDqGx1I0q+LJFdSkRSPbcddpVl2GfcRBhklXYI1y/dvb/3rk/M/
         VVH5+EhekIMiJ5zchjea+5WYH4fnUF47afGpgYQcxVG5G0hPoAcfHhalyU2DDWgLdsrg
         UGKOHpl/sh7ga5svx/RjbyOObf1XFSq8Iek91LRoluT9rFSVIhzMhbHAXxN4RIXXcbZh
         00k2/pCmbXw/4D30kjQNoLxLwgk6Dz9e1UIHKxZOoEYLp8oL3WwKaOLJfFdYTQFV13e2
         f1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROsSP2zJLMpqkNAkCkejAhjTOebhsc8Ura1yv3/lEHk=;
        b=SELwtL2FrkQtoFKYokAsK/xVS3wk0TkEzfw3ylRueMWk1gd9hpYD99MzP+9k6kSZy2
         jsZjaPeAxO+1unBvAdWQz75jmxBov6EmEiODWoTCP9gqR+wW/O6jHZ1641EV3sxQM1J/
         VP88VG13yKlNRKPFiqbvXxTX1pGAhtl7Wvjqo+Rq06kQ55bGAjmzcy6g+YCATvvxGBHD
         lRABCGs7/sLfy1F0pDUZWHKgk+LCIx7bovmCTDQ1M8ATGX4aW1H3oWZlJ9oHegMAGwpV
         8ngR+l0hYfDfQm0NUZhu7kr8HhEtXsWXdRRC5Fq4ZmfrDO0XE9F6wGa0J5R6RVDsUwwc
         o9dw==
X-Gm-Message-State: ACrzQf1RENm778VVEv3GIckLFhK7xCy4csTwjeu4LjtUYyPeNKZqUXVz
        robLwrTqkeRuZEVZ1aelz/M=
X-Google-Smtp-Source: AMsMyM495vmD7fimlGChX5ECDkEgbUrq4CJpt+iqe6EQh4zATNbCGMe0QLoX6Js34e5qejLL1T3sOA==
X-Received: by 2002:a17:90a:13c4:b0:213:9c67:1b09 with SMTP id s4-20020a17090a13c400b002139c671b09mr833259pjf.221.1667849361156;
        Mon, 07 Nov 2022 11:29:21 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a714c00b0020a7d076bfesm4653752pjs.2.2022.11.07.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:29:20 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:29:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Job Noorman <job@noorman.info>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH RESEND v6 1/3] dt-bindings: touchscreen: add Himax
 hx83112b bindings
Message-ID: <Y2lcjWJYkeHljbJQ@google.com>
References: <20221107105604.26541-1-job@noorman.info>
 <20221107105604.26541-2-job@noorman.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107105604.26541-2-job@noorman.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:56:02AM +0100, Job Noorman wrote:
> This patch adds device tree bindings for Himax 83112b touchscreen
> devices.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
