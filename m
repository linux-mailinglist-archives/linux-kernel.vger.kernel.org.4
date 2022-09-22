Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232775E65A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiIVOc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiIVOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:32:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C82FCA7A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:31:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so14956136lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E+KMosBqXSWQlE/JQgUvo901l97D1VfyZtQi7a+eaBY=;
        b=bKjdwmQdIsRhCzp8BN5ejl7lXzlVG9u4TBXX4vP00avhtbdUSbTFpZSYqzrwPXCUOG
         +ToQ0LwsALIkPQ+/BrU1D1LrPJdqhAtcLdmAVpXZKGjpjMS4MNQivm1qsm/HIn7zRMSh
         tdc2y8KYcN5Fr9+5ON2UJvjVUSbgqz5RY91NQdeW7O535eDOncQsRlvmD4NKOm6J7XaD
         SGVaHe+LfFW/1U8fJcTIOCcKcgPvsGVm1p0qjXcZjqPDP3ILpmqV9u036uEyTjiD97rB
         iUO9mIoMHEGepXA2f+IQ+Q9E+m98bYijCSngX2ml4sIkn8cNH1X1kWarOunnrEx2BJPb
         9leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E+KMosBqXSWQlE/JQgUvo901l97D1VfyZtQi7a+eaBY=;
        b=U6n3evfY3WdHRD+lNBlqlhkCk/VjNtka7G5bYgUYjIAxqJTM1ZNI4PSSOTqm+zzUWC
         aeG/jRPpAh1Q7ghiLXlHHfj2xuLKpN3U/lBbkxyYc5rGD5sUYmdROnidYcg93ZwilgfB
         7ejCpku8udgcbCBlVDvvx6o7b7EpE27/CoN9/SoGIPnLZ35MbdZHgT1nZjvze001w00+
         m+jAmZbt5BMb1d+tVMpo6jPDT/rUuqumzV1xEW/nChNAstmml2gGzn3Y26tnszZclV6M
         h/7XNaCnWyYgxBVXPcWn0HrjKjT6y2HZv64htfEd0DNQlv9cn8kCFpNFYSPEkiMYeY8d
         LdkA==
X-Gm-Message-State: ACrzQf0xiep8tXStQbw7O9+O0AEztExw7A+CyCuhBo6fl8Okd7oFtb93
        p+5codKqL0n1JNAyqiPoDBnFUw==
X-Google-Smtp-Source: AMsMyM6un4zgO8RmL2hWz4cb8M81IBCUXIv0rKrWRghKhToBwcV4LTSaNzS3G2jviAiaCrN+trVhlw==
X-Received: by 2002:ac2:4429:0:b0:497:a5e9:d14a with SMTP id w9-20020ac24429000000b00497a5e9d14amr1484897lfl.372.1663857115721;
        Thu, 22 Sep 2022 07:31:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t26-20020a2e9d1a000000b0026c297a9e11sm930815lji.133.2022.09.22.07.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:31:55 -0700 (PDT)
Message-ID: <3b795603-8300-793c-96e4-c4ba443ff1fb@linaro.org>
Date:   Thu, 22 Sep 2022 17:31:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/17] phy: qcom-qmp-pcie-msm8996: drop unused type from
 config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> The configuration PHY type is no longer used since the QMP driver split
> so drop it from the configuration.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

