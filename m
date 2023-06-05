Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB90721BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjFEC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:27:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C979BB8;
        Sun,  4 Jun 2023 19:27:50 -0700 (PDT)
Received: from loongson.cn (unknown [223.106.25.146])
        by gateway (Coremail) with SMTP id _____8CxqPElSH1kNogEAA--.9462S3;
        Mon, 05 Jun 2023 10:27:49 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.106.25.146])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axo8AgSH1kUzGKAA--.25676S3;
        Mon, 05 Jun 2023 10:27:45 +0800 (CST)
Message-ID: <2fad9d11-ecc6-aa3d-8c0b-14b1f196ce74@loongson.cn>
Date:   Mon, 5 Jun 2023 10:27:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused gpio_cansleep()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230602150106.47783-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20230602150106.47783-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axo8AgSH1kUzGKAA--.25676S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfGw4rZr1rKry3Cr4rAF43ZFb_yoW8JrW5Ko
        W3Awsruwn7Ja13JrW5Ga1kWFnrursFkrZ5Za1kX3yrKry7tr93Xa18J3y3Ja4fJFyrG3Wf
        GFyxuFWUWrZYyFyUn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi andy,

On 2023/6/2 23:01, Andy Shevchenko wrote:
> There is not a single user in the entire kernel of this deprecated API,
> kill it for good.
>
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> ---
>   Documentation/driver-api/gpio/legacy.rst           | 12 +-----------
>   .../translations/zh_CN/driver-api/gpio/legacy.rst  | 14 +++-----------
>   Documentation/translations/zh_TW/gpio.txt          | 14 +++-----------
>   arch/m68k/include/asm/mcfgpio.h                    |  8 --------
>   arch/mips/include/asm/mach-au1x00/gpio-au1000.h    |  5 -----
>   arch/mips/include/asm/mach-au1x00/gpio-au1300.h    |  5 -----
>   include/linux/gpio.h                               | 12 ------------
>   7 files changed, 7 insertions(+), 63 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
> index 9eda54811faa..b6505914791c 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -165,8 +165,7 @@ Most GPIO controllers can be accessed with memory read/write instructions.
>   Those don't need to sleep, and can safely be done from inside hard
>   (nonthreaded) IRQ handlers and similar contexts.
>   
> -Use the following calls to access such GPIOs,
> -for which gpio_cansleep() will always return false (see below)::
> +Use the following calls to access such GPIOs::
>   
>   	/* GPIO INPUT:  return zero or nonzero */
>   	int gpio_get_value(unsigned gpio);
> @@ -200,13 +199,6 @@ Some GPIO controllers must be accessed using message based busses like I2C
>   or SPI.  Commands to read or write those GPIO values require waiting to
>   get to the head of a queue to transmit a command and get its response.
>   This requires sleeping, which can't be done from inside IRQ handlers.
> -
> -Platforms that support this type of GPIO distinguish them from other GPIOs
> -by returning nonzero from this call (which requires a valid GPIO number,
> -which should have been previously allocated with gpio_request)::
> -
> -	int gpio_cansleep(unsigned gpio);
> -
>   To access such GPIOs, a different set of accessors is defined::
>   
>   	/* GPIO INPUT:  return zero or nonzero, might sleep */
> @@ -215,7 +207,6 @@ To access such GPIOs, a different set of accessors is defined::
>   	/* GPIO OUTPUT, might sleep */
>   	void gpio_set_value_cansleep(unsigned gpio, int value);
>   
> -
>   Accessing such GPIOs requires a context which may sleep,  for example
>   a threaded IRQ handler, and those accessors must be used instead of
>   spinlock-safe accessors without the cansleep() name suffix.
> @@ -537,7 +528,6 @@ code, which always dispatches through the gpio_chip::
>   
>     #define gpio_get_value	__gpio_get_value
>     #define gpio_set_value	__gpio_set_value
> -  #define gpio_cansleep		__gpio_cansleep
>   
>   Fancier implementations could instead define those as inline functions with
>   logic optimizing access to specific SOC-based GPIOs.  For example, if the
> diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> index 1bddecf73670..1c939e352129 100644
> --- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> +++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> @@ -153,8 +153,7 @@ get/set(获取/设置)函数调用没法返回错误,且有可能是配置错误
>   大多数 GPIO 控制器可以通过内存读/写指令来访问。这些指令不会休眠,可以
>   安全地在硬(非线程)中断例程和类似的上下文中完成。
>   
> -对于那些用 gpio_cansleep()测试总是返回失败的 GPIO(见下文)，使用
> -以下的函数访问::
> +对于那些 GPIO，使用 以下的函数访问::
对于那些 GPIO，使用以下的函数访问::
>   
>   	/* GPIO 输入:返回零或非零 */
>   	int gpio_get_value(unsigned gpio);
> @@ -186,11 +185,6 @@ GPIO值是布尔值，零表示低电平，非零表示高电平。当读取一
>   GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其反馈。期间需要
>   休眠，这不能在 IRQ 例程(中断上下文)中执行。
>   
> -支持此类 GPIO 的平台通过以下函数返回非零值来区分出这种 GPIO。(此函数需要
> -一个之前通过 gpio_request 分配到的有效 GPIO 编号)::
> -
> -	int gpio_cansleep(unsigned gpio);
> -
>   为了访问这种 GPIO,内核定义了一套不同的函数::
>   
>   	/* GPIO 输入:返回零或非零 ,可能会休眠 */
> @@ -199,7 +193,6 @@ GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其
>   	/* GPIO 输出,可能会休眠 */
>   	void gpio_set_value_cansleep(unsigned gpio, int value);
>   
> -
>   访问这样的 GPIO 需要一个允许休眠的上下文，例如线程 IRQ 处理例程，并用以上的
>   访问函数替换那些没有 cansleep()后缀的自旋锁安全访问函数。
>   
> @@ -483,8 +476,8 @@ GPIO 实现者的框架（可选）
>   
>   为了支持这个框架，一个平台的 Kconfig 文件将会 "select"(选择)
>   ARCH_REQUIRE_GPIOLIB 或 ARCH_WANT_OPTIONAL_GPIOLIB，并让它的
> -<asm/gpio.h> 包含 <asm-generic/gpio.h>，同时定义三个方法:
> -gpio_get_value()、gpio_set_value()和 gpio_cansleep()。
> +<asm/gpio.h> 包含 <asm-generic/gpio.h>，同时定义二个方法:
<asm/gpio.h> 包含 <asm-generic/gpio.h>，同时定义两个方法:
> +gpio_get_value()、gpio_set_value()。
>   
>   它也应提供一个 ARCH_NR_GPIOS 的定义值，这样可以更好地反映该平台 GPIO
>   的实际数量,节省静态表的空间。(这个定义值应该包含片上系统内建 GPIO 和
> @@ -502,7 +495,6 @@ ARCH_WANT_OPTIONAL_GPIOLIB 意味着 gpiolib 核心默认关闭,且用户可以
>   
>     #define gpio_get_value	__gpio_get_value
>     #define gpio_set_value	__gpio_set_value
> -  #define gpio_cansleep		__gpio_cansleep
>   
>   这些定义可以用更理想的实现方法替代，那就是使用经过逻辑优化的内联函数来访问
>   基于特定片上系统的 GPIO。例如,若引用的 GPIO (寄存器位偏移)是常量“12”，
> diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
> index 66bc7f2bbe53..6d5188109f9f 100644
> --- a/Documentation/translations/zh_TW/gpio.txt
> +++ b/Documentation/translations/zh_TW/gpio.txt
> @@ -161,8 +161,7 @@ get/set(獲取/設置)函數調用沒法返回錯誤,且有可能是配置錯誤
>   大多數 GPIO 控制器可以通過內存讀/寫指令來訪問。這些指令不會休眠,可以
>   安全地在硬(非線程)中斷例程和類似的上下文中完成。
>   
> -對於那些用 gpio_cansleep()測試總是返回失敗的 GPIO(見下文)，使用
> -以下的函數訪問:
> +對於那些 GPIO，使用 以下的函數訪問:
對於那些 GPIO，使用以下的函數訪問:
>   
>   	/* GPIO 輸入:返回零或非零 */
>   	int gpio_get_value(unsigned gpio);
> @@ -193,11 +192,6 @@ GPIO值是布爾值，零表示低電平，非零表示高電平。當讀取一
>   GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其反饋。期間需要
>   休眠，這不能在 IRQ 例程(中斷上下文)中執行。
>   
> -支持此類 GPIO 的平台通過以下函數返回非零值來區分出這種 GPIO。(此函數需要
> -一個之前通過 gpio_request 分配到的有效 GPIO 編號):
> -
> -	int gpio_cansleep(unsigned gpio);
> -
>   爲了訪問這種 GPIO,內核定義了一套不同的函數:
>   
>   	/* GPIO 輸入:返回零或非零 ,可能會休眠 */
> @@ -206,7 +200,6 @@ GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其
>   	/* GPIO 輸出,可能會休眠 */
>   	void gpio_set_value_cansleep(unsigned gpio, int value);
>   
> -
>   訪問這樣的 GPIO 需要一個允許休眠的上下文，例如線程 IRQ 處理例程，並用以上的
>   訪問函數替換那些沒有 cansleep()後綴的自旋鎖安全訪問函數。
>   
> @@ -449,8 +442,8 @@ GPIO 實現者的框架 (可選)
>   -------
>   爲了支持這個框架，一個平台的 Kconfig 文件將會 "select"(選擇)
>   ARCH_REQUIRE_GPIOLIB 或 ARCH_WANT_OPTIONAL_GPIOLIB，並讓它的
> -<asm/gpio.h> 包含 <asm-generic/gpio.h>，同時定義三個方法:
> -gpio_get_value()、gpio_set_value()和 gpio_cansleep()。
> +<asm/gpio.h> 包含 <asm-generic/gpio.h>，同時定義兩個方法:
> +gpio_get_value()、gpio_set_value()。
>   
>   它也應提供一個 ARCH_NR_GPIOS 的定義值，這樣可以更好地反映該平台 GPIO
>   的實際數量,節省靜態表的空間。(這個定義值應該包含片上系統內建 GPIO 和
> @@ -468,7 +461,6 @@ ARCH_WANT_OPTIONAL_GPIOLIB 意味著 gpiolib 核心默認關閉,且用戶可以
>   
>     #define gpio_get_value	__gpio_get_value
>     #define gpio_set_value	__gpio_set_value
> -  #define gpio_cansleep		__gpio_cansleep
>   
>   這些定義可以用更理想的實現方法替代，那就是使用經過邏輯優化的內聯函數來訪問
>   基於特定片上系統的 GPIO。例如,若引用的 GPIO (寄存器位偏移)是常量「12」，
>
Thanks,

Yanteng

> diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
> index 2cefe8445980..7abd322c019f 100644
> --- a/arch/m68k/include/asm/mcfgpio.h
> +++ b/arch/m68k/include/asm/mcfgpio.h
> @@ -34,14 +34,6 @@ static inline void __gpio_set_value(unsigned gpio, int value)
>   		__mcfgpio_set_value(gpio, value);
>   }
>   
> -static inline int __gpio_cansleep(unsigned gpio)
> -{
> -	if (gpio < MCFGPIO_PIN_MAX)
> -		return 0;
> -	else
> -		return -EINVAL;
> -}
> -
>   static inline int __gpio_to_irq(unsigned gpio)
>   {
>   	return -EINVAL;
> diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> index adde1fa5097e..82bc2766e2ec 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> @@ -500,11 +500,6 @@ static inline int alchemy_gpio_is_valid(int gpio)
>   		alchemy_gpio1_is_valid(gpio);
>   }
>   
> -static inline int alchemy_gpio_cansleep(int gpio)
> -{
> -	return 0;	/* Alchemy never gets tired */
> -}
> -
>   static inline int alchemy_gpio_to_irq(int gpio)
>   {
>   	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> index d16add7ba49d..43d44f384f97 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> @@ -98,11 +98,6 @@ static inline int au1300_gpio_is_valid(unsigned int gpio)
>   	return ret;
>   }
>   
> -static inline int au1300_gpio_cansleep(unsigned int gpio)
> -{
> -	return 0;
> -}
> -
>   /* hardware remembers gpio 0-63 levels on powerup */
>   static inline int au1300_gpio_getinitlvl(unsigned int gpio)
>   {
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 88efac969754..7ecc25c543ce 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -108,11 +108,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
>   	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
>   }
>   
> -static inline int gpio_cansleep(unsigned gpio)
> -{
> -	return gpiod_cansleep(gpio_to_desc(gpio));
> -}
> -
>   static inline int gpio_to_irq(unsigned gpio)
>   {
>   	return gpiod_to_irq(gpio_to_desc(gpio));
> @@ -195,13 +190,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
>   	WARN_ON(1);
>   }
>   
> -static inline int gpio_cansleep(unsigned gpio)
> -{
> -	/* GPIO can never have been requested or set as {in,out}put */
> -	WARN_ON(1);
> -	return 0;
> -}
> -
>   static inline int gpio_get_value_cansleep(unsigned gpio)
>   {
>   	/* GPIO can never have been requested or set as {in,out}put */

