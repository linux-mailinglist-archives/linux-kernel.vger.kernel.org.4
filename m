Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E638666045E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjAFQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAFQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:37:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB4878A5D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:37:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so1439712wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2/wW8oWU2UO8G+hBvXbq+ylbwBDQdJAzgI/Jam/m+c=;
        b=P0csNwpg9MOjalR15dbOZ1LUq6TdUofEE7438rE/cpAX6qEn5+mMoWvJXJC6ZpwDXi
         EARyvmG1YWxE3zP8yqecpslPwHBQqDrVX25OOeNKcNA4wogZKUTF21SDNUxtcohel9tV
         uyrmTwytfXzK01YXqFqnvwRbqTmq1slYryNo/Rr9NvXFfeJfSIv/Vmi2tlxrQ/Vq6vX8
         2FVWVdbganGHT5PwcT5KSp1Z2Bh+9KufRjFHVx4f1iL9FdE9z650VAAIsK053hbFtN38
         WjudDhMIuOe+JqvyoB12nLnQzAfugau3CkZyjmbbxBmEnWdKrqVrcPp3S78J0Vydyz/y
         FWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G2/wW8oWU2UO8G+hBvXbq+ylbwBDQdJAzgI/Jam/m+c=;
        b=H6qlMfz14IZgkHJeV7flG+fU4LHdFzfGiweM3s+xhpXhiI1LBVt9tsJ4KGcaxcSgQA
         LR2LX7q9ibm7EcbnO4Ic6HLQ1XDbxRKjpHeuNug/CjuCqE2NJOE7PqhA+lNiqGBnRe3i
         9SJChwXHVrSkUtgBMTntgT4gwXG2J2y/7GRbhTcwevgpHD4kGQGqvsS3tW8cx2aNYjH7
         INzkxfGLZZ8JBBQ6YT5fcG8AbWcm6IH3uqYpS92ERC2Oi8WDp0gmPDwwdWl4xVTE5nCZ
         I6s0eeRmYy1Z0ZnH+SLMnpEBGiDbKqj1owIaeoIxwe4zJpu+eJyZ13TEy/KTobZy7To4
         a6ew==
X-Gm-Message-State: AFqh2kr/N3zYQRwhw5JM0DA1L+TVMtcWLB1yed17pKhahByTt4vGKuCh
        716Z5qoN6K0qjzZEcT7jKv0jKA==
X-Google-Smtp-Source: AMrXdXvPO6YvRPMFNA4tbcS1PTYl42JBHmgSt22BHUKuhzVUtPqixbPCPJIe9ANjVG/6QbqyJYPZYw==
X-Received: by 2002:a05:600c:4d21:b0:3d2:2a72:2573 with SMTP id u33-20020a05600c4d2100b003d22a722573mr40022929wmp.11.1673023039183;
        Fri, 06 Jan 2023 08:37:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l7-20020a5d6747000000b002b57bae7174sm1617699wrw.5.2023.01.06.08.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 08:37:18 -0800 (PST)
Message-ID: <e0ced334-e6c1-caeb-322a-f67a23ee58da@linaro.org>
Date:   Fri, 6 Jan 2023 17:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Annoying message on the console for the db845c board
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Does anyone have an idea on how to fix these timeout messages ? They are 
displayed again and again every 5 seconds and that saturates the 
filesystem after awhile.

...
[   24.662181] qcom-q6v5-mss 4080000.remoteproc: start timed out
[   24.768150] qcom-q6v5-mss 4080000.remoteproc: port failed halt
[   24.777618] remoteproc remoteproc0: can't start rproc 
4080000.remoteproc: -110
[   24.785022] remoteproc remoteproc0: Boot failed: -110
[   24.833657] remoteproc remoteproc0: powering up 4080000.remoteproc
[   24.840126] remoteproc remoteproc0: Booting fw image 
qcom/sdm845/mba.mbn, size 238304
[   24.897361] qcom-q6v5-mss 4080000.remoteproc: MBA booted without 
debug policy, loading mpss
[   31.573938] qcom-q6v5-mss 4080000.remoteproc: start timed out
[   31.680229] qcom-q6v5-mss 4080000.remoteproc: port failed halt
[   31.689683] remoteproc remoteproc0: can't start rproc 
4080000.remoteproc: -110
[   31.697070] remoteproc remoteproc0: Boot failed: -110
[   31.765283] remoteproc remoteproc0: powering up 4080000.remoteproc
[   31.771758] remoteproc remoteproc0: Booting fw image 
qcom/sdm845/mba.mbn, size 238304
[   31.820553] qcom-q6v5-mss 4080000.remoteproc: MBA booted without 
debug policy, loading mpss
....

Thanks
   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
