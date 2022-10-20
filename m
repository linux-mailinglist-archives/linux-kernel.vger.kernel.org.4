Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37E6059CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJTIbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJTIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:31:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD6F15F932
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:31:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp15so32283371lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDK8YFBcYlO96C3KJm7NrQCSaicS4eCQwBe4/7dKC8=;
        b=FI6eR3DYXht8+m9UalT4gkpR82tvRlAezR/K/yaB8vkJH28jtBAkdGh2XY/CykH9mj
         KYZvIT98Yoyr1KycI4HGdn/JzFWGOQ5UZEqfKDGfFavS9jHlHNlLuy67jOmEN1K8xUqj
         k4mrBaMSrb1UYIWVWz/8DZXLT3JV3JpkjwzePnKwpIYJA8Vr/qwOMsPLikI/xdfgJA2p
         3J9P/BMI0AcxZZUQnO0GdYDnJAietkBkHVzeBhv/u9q4FBzJRcRhN825M/mnEEJBS6Tx
         zPPYp8ZrrgvhdxFH5J0JRK8uGVsy6VIghNPcowfVTZhQsiyGsUmM78LrHCsPOjxmqChq
         smjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KgDK8YFBcYlO96C3KJm7NrQCSaicS4eCQwBe4/7dKC8=;
        b=m8sXWnMIDa74beTIdehYhk7dKSjMlu5BOnQM75jSXbzlWZGUKYMdhmw6O4GFQCgWji
         phjzZx+vxnA9GChacs//Wt8mDnKIG44HESVszfQ4OC0XoEM0qrSR9rcWNLe2Jk4e1Fh7
         1Tk/apr+XPkgGxf98Kgz5KZvVGClLhPlTj+WbAKDxiKDkfaW5wcUHEEAz0CUzzIPjPoA
         dy7QlQPOx6wV57VG9o4NKaru5oqI9keZ1rVUQib4z5BhfHAWxqGHaoFDERMCUxjtgyZ5
         frEuB1zTur+R1ODPpsLmP+lBh8E+SLnopr1mSoIARa2Bti4qXYq950NWgU5XGJPPubQc
         mkUw==
X-Gm-Message-State: ACrzQf0yP9sKApXJ/PhauPr25OopTq9mIho3WpYEWp4rcTS3uxQHufGI
        oaxPJ5Men13cSdO6seJBtEqVgw==
X-Google-Smtp-Source: AMsMyM5dvXV0bqmHga039wlUAXgeHaA+4elOpcHo3ft59KpTFvuA4ianAGx8LKDVRpd78p2nJPUkwg==
X-Received: by 2002:a19:f71a:0:b0:4a2:4fdb:5037 with SMTP id z26-20020a19f71a000000b004a24fdb5037mr4773857lfe.535.1666254696819;
        Thu, 20 Oct 2022 01:31:36 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v14-20020a2ea44e000000b0026c35c4720esm2834569ljn.24.2022.10.20.01.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:31:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------i082W3S8x1RX9AUAq7cYn8mr"
Message-ID: <325d6c7b-ca96-df73-a792-4d156a710267@linaro.org>
Date:   Thu, 20 Oct 2022 11:31:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 13/15] phy: qcom-qmp-pcie: add support for pipediv2
 clock
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-14-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------i082W3S8x1RX9AUAq7cYn8mr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/10/2022 14:35, Johan Hovold wrote:
> Some QMP PHYs have a second fixed-divider pipe clock that needs to be
> enabled along with the pipe clock.
> 
> Add support for an optional "pipediv2" clock.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 9c8e009033f1..c1d74c06fad1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1379,7 +1379,9 @@ struct qmp_pcie {
>   	void __iomem *rx2;
>   
>   	struct clk *pipe_clk;
> +	struct clk *pipediv2_clk;
>   	struct clk_bulk_data *clks;
> +
>   	struct reset_control_bulk_data *resets;
>   	struct regulator_bulk_data *vregs;
>   
> @@ -1902,6 +1904,36 @@ static int qmp_pcie_exit(struct phy *phy)
>   	return 0;
>   }
>   
> +static int pipe_clk_enable(struct qmp_pcie *qmp)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable pipe clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(qmp->pipediv2_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable pipediv2 clock: %d\n", ret);
> +		goto err_disable_pipe_clk;
> +	}
> +
> +	return 0;
> +
> +err_disable_pipe_clk:
> +	clk_disable_unprepare(qmp->pipe_clk);
> +
> +	return ret;
> +}
> +
> +static void pipe_clk_disable(struct qmp_pcie *qmp)
> +{
> +	clk_disable_unprepare(qmp->pipediv2_clk);
> +	clk_disable_unprepare(qmp->pipe_clk);
> +}
> +
>   static int qmp_pcie_power_on(struct phy *phy)
>   {
>   	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> @@ -1923,11 +1955,9 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_init_registers(qmp, &cfg->tables);
>   	qmp_pcie_init_registers(qmp, mode_tables);
>   
> -	ret = clk_prepare_enable(qmp->pipe_clk);
> -	if (ret) {
> -		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +	ret = pipe_clk_enable(qmp);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> @@ -1950,7 +1980,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	return 0;
>   
>   err_disable_pipe_clk:
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	pipe_clk_disable(qmp);
>   
>   	return ret;
>   }
> @@ -1960,7 +1990,7 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	pipe_clk_disable(qmp);
>   
>   	/* PHY reset */
>   	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

I still think that the attached patch is somewhat simpler. Diffstat 
supports that idea:

$ diffstat /tmp/pipe.diff
  phy-qcom-qmp-pcie.c |   26 ++++++++++++++++----------
  1 file changed, 16 insertions(+), 10 deletions(-)

Yes, I'm speaking this after having cleaned up several open-coded 
versions of clk_bulk_foo from the drm/msm code. It typically starts with 
the 'just another clock' story, and then suddenly they are all over the 
code.

-- 
With best wishes
Dmitry

--------------i082W3S8x1RX9AUAq7cYn8mr
Content-Type: text/x-patch; charset=UTF-8; name="pipe.diff"
Content-Disposition: attachment; filename="pipe.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1xY29tLXFtcC1wY2llLmMg
Yi9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1xbXAtcGNpZS5jCmluZGV4IDljOGUw
MDkwMzNmMS4uYTE0OGIxNDNkZDkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BoeS9xdWFsY29t
bS9waHktcWNvbS1xbXAtcGNpZS5jCisrKyBiL2RyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1x
Y29tLXFtcC1wY2llLmMKQEAgLTEzNzgsOCArMTM3OCwxMCBAQCBzdHJ1Y3QgcW1wX3BjaWUg
ewogCXZvaWQgX19pb21lbSAqdHgyOwogCXZvaWQgX19pb21lbSAqcngyOwogCi0Jc3RydWN0
IGNsayAqcGlwZV9jbGs7CisJc3RydWN0IGNsa19idWxrX2RhdGEgKnBpcGVfY2xrczsKKwlp
bnQgbnVtX3BpcGVfY2xrczsKIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSAqY2xrczsKKwogCXN0
cnVjdCByZXNldF9jb250cm9sX2J1bGtfZGF0YSAqcmVzZXRzOwogCXN0cnVjdCByZWd1bGF0
b3JfYnVsa19kYXRhICp2cmVnczsKIApAQCAtMTkyMywxMSArMTkyNSw5IEBAIHN0YXRpYyBp
bnQgcW1wX3BjaWVfcG93ZXJfb24oc3RydWN0IHBoeSAqcGh5KQogCXFtcF9wY2llX2luaXRf
cmVnaXN0ZXJzKHFtcCwgJmNmZy0+dGFibGVzKTsKIAlxbXBfcGNpZV9pbml0X3JlZ2lzdGVy
cyhxbXAsIG1vZGVfdGFibGVzKTsKIAotCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShxbXAt
PnBpcGVfY2xrKTsKLQlpZiAocmV0KSB7Ci0JCWRldl9lcnIocW1wLT5kZXYsICJwaXBlX2Ns
ayBlbmFibGUgZmFpbGVkIGVycj0lZFxuIiwgcmV0KTsKKwlyZXQgPSBjbGtfYnVsa19wcmVw
YXJlX2VuYWJsZShxbXAtPm51bV9waXBlX2Nsa3MsIHFtcC0+cGlwZV9jbGtzKTsKKwlpZiAo
cmV0KQogCQlyZXR1cm4gcmV0OwotCX0KIAogCS8qIFB1bGwgUEhZIG91dCBvZiByZXNldCBz
dGF0ZSAqLwogCXFwaHlfY2xyYml0cyhwY3MsIGNmZy0+cmVnc1tRUEhZX1NXX1JFU0VUXSwg
U1dfUkVTRVQpOwpAQCAtMTk1MCw3ICsxOTUwLDcgQEAgc3RhdGljIGludCBxbXBfcGNpZV9w
b3dlcl9vbihzdHJ1Y3QgcGh5ICpwaHkpCiAJcmV0dXJuIDA7CiAKIGVycl9kaXNhYmxlX3Bp
cGVfY2xrOgotCWNsa19kaXNhYmxlX3VucHJlcGFyZShxbXAtPnBpcGVfY2xrKTsKKwljbGtf
YnVsa19kaXNhYmxlX3VucHJlcGFyZShxbXAtPm51bV9waXBlX2Nsa3MsIHFtcC0+cGlwZV9j
bGtzKTsKIAogCXJldHVybiByZXQ7CiB9CkBAIC0xOTYwLDcgKzE5NjAsNyBAQCBzdGF0aWMg
aW50IHFtcF9wY2llX3Bvd2VyX29mZihzdHJ1Y3QgcGh5ICpwaHkpCiAJc3RydWN0IHFtcF9w
Y2llICpxbXAgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsKIAljb25zdCBzdHJ1Y3QgcW1wX3Bo
eV9jZmcgKmNmZyA9IHFtcC0+Y2ZnOwogCi0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHFtcC0+
cGlwZV9jbGspOworCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKHFtcC0+bnVtX3BpcGVf
Y2xrcywgcW1wLT5waXBlX2Nsa3MpOwogCiAJLyogUEhZIHJlc2V0ICovCiAJcXBoeV9zZXRi
aXRzKHFtcC0+cGNzLCBjZmctPnJlZ3NbUVBIWV9TV19SRVNFVF0sIFNXX1JFU0VUKTsKQEAg
LTIxNTQsNiArMjE1NCw3IEBAIHN0YXRpYyBpbnQgcW1wX3BjaWVfcGFyc2VfZHRfbGVnYWN5
KHN0cnVjdCBxbXBfcGNpZSAqcW1wLCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wCiAJc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShxbXAtPmRldik7
CiAJY29uc3Qgc3RydWN0IHFtcF9waHlfY2ZnICpjZmcgPSBxbXAtPmNmZzsKIAlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSBxbXAtPmRldjsKKwlzdHJ1Y3QgY2xrICpjbGs7CiAKIAlxbXAtPnNl
cmRlcyA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsKIAlpZiAo
SVNfRVJSKHFtcC0+c2VyZGVzKSkKQEAgLTIyMDYsMTIgKzIyMDcsMTcgQEAgc3RhdGljIGlu
dCBxbXBfcGNpZV9wYXJzZV9kdF9sZWdhY3koc3RydWN0IHFtcF9wY2llICpxbXAsIHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAKIAkJfQogCX0KIAotCXFtcC0+cGlwZV9jbGsgPSBkZXZtX2dl
dF9jbGtfZnJvbV9jaGlsZChkZXYsIG5wLCBOVUxMKTsKLQlpZiAoSVNfRVJSKHFtcC0+cGlw
ZV9jbGspKSB7Ci0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihxbXAtPnBp
cGVfY2xrKSwKKwljbGsgPSBkZXZtX2dldF9jbGtfZnJvbV9jaGlsZChkZXYsIG5wLCBOVUxM
KTsKKwlpZiAoSVNfRVJSKGNsaykpIHsKKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQ
VFJfRVJSKGNsayksCiAJCQkJICAgICAiZmFpbGVkIHRvIGdldCBwaXBlIGNsb2NrXG4iKTsK
IAl9CiAKKwlxbXAtPm51bV9waXBlX2Nsa3MgPSAxOworCXFtcC0+cGlwZV9jbGtzID0gZGV2
bV9rY2FsbG9jKGRldiwgcW1wLT5udW1fcGlwZV9jbGtzLAorCQkJCSAgICAgIHNpemVvZigq
cW1wLT5waXBlX2Nsa3MpLCBHRlBfS0VSTkVMKTsKKwlxbXAtPnBpcGVfY2xrc1swXS5jbGsg
PSBjbGs7CisKIAlyZXR1cm4gMDsKIH0KIAo=

--------------i082W3S8x1RX9AUAq7cYn8mr--
