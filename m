Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E796D229F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCaO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjCaO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:28:11 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3720C01
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g19so21787805qts.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272846; x=1682864846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovU31hB83XMxRuvQsZcOBkvqCc2tCiYd8mVr7X/VGuU=;
        b=oUoKSDrgPNpD6m7Lqp0V8yC3WuZ3OehDUyirBcPRLk3PZHk1Gn9ZcbE1yBKMRYH2AP
         fjvGRL+MOhbb6exgBqG4kwc5QULmtV2wXOHkNzglsqZAYQbtML+9/Pw1MaqbdU6PH93t
         SiXevR6eNZtKWfl884OUU1H35rRVnGG7DdfRWdDeKbZgVHYs6TriHPgTc1nsHpN6guPg
         sfxsuqNdz1qNLukijvVcBIggaD0+qFnoxZKTFMIYzGQpE2xuf6PDKs7VfYf9nklNXVX9
         VC2dyPi+WpHNgGaQXqq1sExi9KYzxLgjTQoH1drzxmOtNivHN13hVUneEAArxpnH4ol9
         XApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272846; x=1682864846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovU31hB83XMxRuvQsZcOBkvqCc2tCiYd8mVr7X/VGuU=;
        b=GDhI6cYFQYLgp+K6yygaOrgenr8vA3TcK5TkQNKTgGSL2Os8nEZMNF/knngAj+tOsH
         SPiJuotIWWwVbAsoiMzgwTRNUtXoF3bZ5saPzAXCFxFMoFTmdtbPZ4mQZNNMjRM0rIci
         +HeP88BflaXlmQNWvAaMnRy2KmuVvKCE6L59MQCZhfIMxbSD+iDFVQTmL5Rdv7ODtLj6
         Pr76csqR80wyAOZeigIELQRKvH98ieyOVqE+4zjWcgeO+GgY4pT6xkHhVH76segfDO7o
         rDTYLuhj9YqXD9Wt4NJarSd/macbgyftBdl+rinng97KQc5T9jIxkwbbamYEKJPO0E5v
         eL6A==
X-Gm-Message-State: AAQBX9cmFwYHjOhL1w0uVszKk7dvfadbe06RWH6yr8FXig6rvS7IxJOd
        /AzQRJ23iDSABptd3Kn/aXz7Qw==
X-Google-Smtp-Source: AKy350ba/HmTG59/0ZwTkuQJMZac0m7+0VObYhtuBg3FOuNR8IRNULKuMY+8+G7Nuj6f89cA6toZAg==
X-Received: by 2002:a05:622a:174c:b0:3e6:326c:c904 with SMTP id l12-20020a05622a174c00b003e6326cc904mr9535154qtk.4.1680272845931;
        Fri, 31 Mar 2023 07:27:25 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id bm20-20020a05620a199400b007435a646354sm711881qkb.0.2023.03.31.07.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:27:25 -0700 (PDT)
Message-ID: <a291399a-2889-0c4c-8524-e5d0a2da2e9e@linaro.org>
Date:   Fri, 31 Mar 2023 09:27:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 21/26] virt: gunyah: Add IO handlers
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-22-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-22-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 7:06 PM, Elliot Berman wrote:
> Add framework for VM functions to handle stage-2 write faults from Gunyah
> guest virtual machines. IO handlers have a range of addresses which they
> apply to. Optionally, they may apply to only when the value written
> matches the IO handler's value.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Two (related) bugs and a suggestion that might help avoid
adding the same problem in the future.  (Or maybe I made
that suggestion elsewhere?  Anyway, you'll see.)

					-Alex

> ---
>   drivers/virt/gunyah/vm_mgr.c  | 94 +++++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h  |  4 ++
>   include/linux/gunyah_vm_mgr.h | 25 ++++++++++
>   3 files changed, 123 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index 0269bcdaf692..b31fac15ff45 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -233,6 +233,100 @@ static void gh_vm_add_resource(struct gh_vm *ghvm, struct gh_resource *ghrsc)
>   	mutex_unlock(&ghvm->resources_lock);
>   }
>   
> +static int _gh_vm_io_handler_compare(const struct rb_node *node, const struct rb_node *parent)
> +{
> +	struct gh_vm_io_handler *n = container_of(node, struct gh_vm_io_handler, node);
> +	struct gh_vm_io_handler *p = container_of(parent, struct gh_vm_io_handler, node);
> +
> +	if (n->addr < p->addr)
> +		return -1;
> +	if (n->addr > p->addr)
> +		return 1;
> +	if ((n->len && !p->len) || (!n->len && p->len))
> +		return 0;
> +	if (n->len < p->len)
> +		return -1;
> +	if (n->len > p->len)
> +		return 1;

The datamatch field in a gh_vm_io_handler structure is Boolean.
If this is what you intend, it would be better to not treat
them as integer values (i.e., don't use < and >).

However I *think* what you want is to be comparing the
data fields here.  If so, this is a BUG.

I think you should maybe use "data" in the gh_fn_ioeventfd_arg
structure rather than "datamatch".  And then use "datamatch"
consistently as a Boolean indicating whether to do matching,
and "data" to be the value used in matching.

> +	if (n->datamatch < p->datamatch)
> +		return -1;
> +	if (n->datamatch > p->datamatch)
> +		return 1;
> +	return 0;
> +}
> +
> +static int gh_vm_io_handler_compare(struct rb_node *node, const struct rb_node *parent)
> +{
> +	return _gh_vm_io_handler_compare(node, parent);
> +}
> +
> +static int gh_vm_io_handler_find(const void *key, const struct rb_node *node)
> +{
> +	const struct gh_vm_io_handler *k = key;
> +
> +	return _gh_vm_io_handler_compare(&k->node, node);
> +}
> +
> +static struct gh_vm_io_handler *gh_vm_mgr_find_io_hdlr(struct gh_vm *ghvm, u64 addr,
> +								u64 len, u64 data)
> +{
> +	struct gh_vm_io_handler key = {
> +		.addr = addr,
> +		.len = len,
> +		.datamatch = data,

The datamatch field here is Boolean.  I'm pretty sure you
want to assign the data field instead, in which case, this
is a BUG.

If you *do* intend to treat the data assigned as Boolean,
please use !!data to make this obvious.

> +	};
> +	struct rb_node *node;
> +
> +	node = rb_find(&key, &ghvm->mmio_handler_root, gh_vm_io_handler_find);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct gh_vm_io_handler, node);
> +}
> +
> +int gh_vm_mmio_write(struct gh_vm *ghvm, u64 addr, u32 len, u64 data)
> +{
> +	struct gh_vm_io_handler *io_hdlr = NULL;
> +	int ret;
> +
> +	down_read(&ghvm->mmio_handler_lock);
> +	io_hdlr = gh_vm_mgr_find_io_hdlr(ghvm, addr, len, data);
> +	if (!io_hdlr || !io_hdlr->ops || !io_hdlr->ops->write) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = io_hdlr->ops->write(io_hdlr, addr, len, data);
> +
> +out:
> +	up_read(&ghvm->mmio_handler_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_mmio_write);

. . .
